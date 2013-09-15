class Givers::PerspectivesController < ApplicationController
  before_filter :require_login

  def index
    @giver = Giver.find(params[:giver_id])
    if @giver.game.blank?
      @giver.build_game.save
    end
  end

  def game_1
    @giver = Giver.find(params[:giver_id])
    
    @game = @giver.game.present? ? @giver.game : @giver.build_game

    if request.post?
      @game = @giver.build_game(params[:game])
      if @game.save
        @game.complete_game(1)
      end
    elsif request.put?
      @game.update_attributes(params[:game])
      if @game.save
        @game.complete_game(1)
      end
    end

    if params[:next].present?
      redirect_to :action => :game_2
    elsif params[:return].present?
      redirect_to :action => :index
    end
  end
  
  def game_2
    @giver = Giver.find(params[:giver_id])
  end

  def experience
  	@giver = Giver.find(params[:giver_id])
    @experience = Experience.find(params[:experience_id])

    if request.post?
      @skill = Skill.find(params[:skill_id])
      @experience.skills << @skill
      @giver.game.complete_game(2)
    end
  end

  def education
    @giver = Giver.find(params[:giver_id])
    @education = Education.find(params[:education_id])

    if request.post?
      @skill = Skill.find(params[:skill_id])
      @education.skills << @skill
      @giver.game.complete_game(2)
    end
  end


  def game_3
  	@giver = Giver.find(params[:giver_id])

    @experiences_or_educations = []
    @experiences_or_educations += @giver.experiences.not_rated.sample(3)
  	
  	if @experiences_or_educations.size < 3
      @experiences_or_educations += @giver.educations.not_rated.sample(3 - @experiences_or_educations.size)
  	end

    if request.post?
      if params[:feelings].has_key?(:Experience)
        params[:feelings][:Experience].each do |ex|
          experience = Experience.find(ex.first)
          experience.feelings = ex.last
          experience.save
        end
      end

      if params[:feelings].has_key?(:Education)
        params[:feelings][:Education].each do |ed|
          education = Education.find(ed.first)
          education.feelings = ed.last
          education.save
        end
      end

      if @giver.game.update_attributes(params[:game])
        @giver.game.complete_game(3)
      end

      if @giver.game.completed_3_games?
        @giver.level = 2
        @giver.save
        flash[:notice] = "Congratulations, you've reached Level 2 and unlocked access to Sessions!  See your Dashboard for more details."
      end

      redirect_to :action => :index
    end
  end

end
