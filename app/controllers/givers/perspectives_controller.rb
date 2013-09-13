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

  	giver = current_user 
  	
  	giver_experiences = giver.experiences
  	giver_experiences = [] if giver_experiences.nil?
  	giver_experiences_count = giver.experiences.count
  	
  	if giver_experiences_count < 3
  		giver_educations = giver.educations
  		unless giver_educations.blank?
  			giver_experiences << giver_educations.sample(1)
  		end
  	end

  	@random_giver_experiences = giver_experiences.sample(3)

  end

  def share_story

  	if request.post?
  		create_story = current_user.build_game(:good_story =>params[:good_story], :bad_story => params[:bad_story], :ugly_story => params[:ugly_story])
  		create_story.anonymous = params[:anonymous] if params[:anonymous].present?
  		
  		if create_story.save
  			redirect_to giver_perspectives_path(current_user) , :notice => "Game has been successfully created"
  			return
  		end
  	end

  end

end
