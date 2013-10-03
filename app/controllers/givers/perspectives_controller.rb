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
    @game = @giver.game
    
    if request.post?
      @giver.educations.each do |education|
        education.update_attributes(params[:education][:"#{education.id}"])
      end
      @game.update_attributes(params[:game])
      @game.complete_game(1)
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
    @skill_update = false
    if request.post?
      @experience.update_experience_with_skill(params)
      @giver.game.complete_game(2)
      @skill_update = true
    end
    respond_to do |format|
      format.html {render :layout => false}
      format.js
    end
  end

  def education
    @giver = Giver.find(params[:giver_id])
    @education = Education.find(params[:education_id])
    @skill_update = false
    
    if request.post?
      @education.update_education_with_skill(params)
      @giver.game.complete_game(2)
      @skill_update = true
    end

    respond_to do |format|
      format.html {render :layout => false}
      format.js
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
      if params[:feelings].present? and params[:feelings].has_key?(:Experience)
        params[:feelings][:Experience].each do |ex|
          experience = Experience.find(ex.first)
          experience.feelings = ex.last
          experience.save
        end
      end

      if params[:feelings].present? and params[:feelings].has_key?(:Education)
        params[:feelings][:Education].each do |ed|
          education = Education.find(ed.first)
          education.feelings = ed.last
          education.save
        end
      end

      if params[:perspective][:good_story].present?
        @giver.good_perspective.story = params[:perspective][:good_story]
        @giver.good_perspective.anonymous = params[:perspective][:good_anonymous]
        @giver.good_perspective.save
        params[:perspective][:good_keywords].split(",").each do |keyword|
          @giver.good_perspective.perspective_tags.create(:name => keyword)
        end
      end
      
      if params[:perspective][:bad_story].present?
        @giver.bad_perspective.story = params[:perspective][:bad_story]
        @giver.bad_perspective.anonymous = params[:perspective][:bad_anonymous]
        @giver.bad_perspective.save
        params[:perspective][:bad_keywords].split(",").each do |keyword|
          @giver.bad_perspective.perspective_tags.create(:name => keyword)
        end
      end

      if params[:perspective][:ugly_story].present?
        @giver.ugly_perspective.story = params[:perspective][:ugly_story]
        @giver.ugly_perspective.anonymous = params[:perspective][:ugly_anonymous]
        @giver.ugly_perspective.save
        params[:perspective][:ugly_keywords].split(",").each do |keyword|
          @giver.ugly_perspective.perspective_tags.create(:name => keyword)
        end 
      end  

      good_keywords = params[:perspective][:good_keywords].split(",")
      bad_keywords  = params[:perspective][:bad_keywords].split(",")
      ugly_keywords = params[:perspective][:ugly_keywords].split(",")
      
      all_tags  = (good_keywords.concat(bad_keywords).concat(ugly_keywords)).uniq
      user_tags = current_user.tags
      new_tags  = all_tags - user_tags 

      new_tags.each do |tag|
        current_user.tags.build(:name => tag).save
      end    

      @giver.game.complete_game(3)

      if @giver.game.completed_3_games?
        @giver.level = 2
        @giver.save
        flash[:notice] = "Congratulations, you've reached Level 2 and unlocked access to Sessions!  See your Dashboard for more details."
      end

      redirect_to :action => :index
    end
  end

end
