class Givers::PerspectivesController < ApplicationController
  before_filter :require_login

  def index
    @giver = Giver.find(params[:giver_id])
  end

  def game_1
    @giver = Giver.find(params[:giver_id])
    
    @game = @giver.game.present? ? @giver.game : @giver.build_game

    if request.post?
      @game = @giver.build_game(params[:game])
      @game.save
    elsif request.put?
      @game.update_attributes(params[:game])
      @game.save
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
    end
  end

  def education
    @giver = Giver.find(params[:giver_id])
    @education = Education.find(params[:education_id])

    if request.post?
      @skill = Skill.find(params[:skill_id])
      @education.skills << @skill
    end
  end


  def game_3
    
  end

end
