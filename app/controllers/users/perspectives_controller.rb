class Users::PerspectivesController < ApplicationController
  before_filter :require_login

  def index
    @user = User.find(params[:user_id])
    if @user.game.blank?
      @user.build_game.save
    end
    perspectives = Perspective.all
    @good_stories = perspectives.select{|story| story.story_type.eql?("The Good")}
    @bad_stories = perspectives.select{|story| story.story_type.eql?("The Bad")}
    @ugly_stories = perspectives.select{|story| story.story_type.eql?("The Ugly")}
    @users = User.find(perspectives.collect(&:user_id).uniq)
  end

  def game_1
    @user = User.find(params[:user_id])
    @game = @user.game
    
    if request.post?
      @user.educations.each do |education|
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
    @user = User.find(params[:user_id])
  end

  def experience
  	@user = User.find(params[:user_id])
    @experience = Experience.find(params[:experience_id])
    @skill_update = false
    if request.post?
      @experience.update_experience_with_skill(params)
      @user.game.complete_game(2)
      @skill_update = true
    end
    respond_to do |format|
      format.html {render :layout => false}
      format.js
    end
  end

  def education
    @user = User.find(params[:user_id])
    @education = Education.find(params[:education_id])
    @skill_update = false
    
    if request.post?
      @education.update_education_with_skill(params)
      @user.game.complete_game(2)
      @skill_update = true
    end

    respond_to do |format|
      format.html {render :layout => false}
      format.js
    end
  end

  def game_3
  	@user = User.find(params[:user_id])

    @experiences_or_educations = []
    @experiences_or_educations += @user.experiences.not_rated.sample(3)
  	
  	if @experiences_or_educations.size < 3
      @experiences_or_educations += @user.educations.not_rated.sample(3 - @experiences_or_educations.size)
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
        @user.good_perspective.story = params[:perspective][:good_story]
        @user.good_perspective.anonymous = params[:perspective][:good_anonymous]
        @user.good_perspective.save
        params[:perspective][:good_keywords].split(",").each do |keyword|
          @user.good_perspective.perspective_tags.create(:name => keyword)
        end
      end
      
      if params[:perspective][:bad_story].present?
        @user.bad_perspective.story = params[:perspective][:bad_story]
        @user.bad_perspective.anonymous = params[:perspective][:bad_anonymous]
        @user.bad_perspective.save
        params[:perspective][:bad_keywords].split(",").each do |keyword|
          @user.bad_perspective.perspective_tags.create(:name => keyword)
        end
      end

      if params[:perspective][:ugly_story].present?
        @user.ugly_perspective.story = params[:perspective][:ugly_story]
        @user.ugly_perspective.anonymous = params[:perspective][:ugly_anonymous]
        @user.ugly_perspective.save
        params[:perspective][:ugly_keywords].split(",").each do |keyword|
          @user.ugly_perspective.perspective_tags.create(:name => keyword)
        end 
      end  

      good_keywords = params[:perspective][:good_keywords].split(",")
      bad_keywords  = params[:perspective][:bad_keywords].split(",")
      ugly_keywords = params[:perspective][:ugly_keywords].split(",")
      
      all_tags  = (good_keywords.concat(bad_keywords).concat(ugly_keywords)).uniq
      user_tags = current_user.tags.collect(&:name)
      new_tags  = all_tags - user_tags 

      unless new_tags.blank?
        new_tags.each do |tag|
          current_user.tags.build(:name => tag).save 
        end
      end    

      @user.game.complete_game(3)

      if @user.game.completed_3_games?
        @user.level = 2
        @user.save
        flash[:notice] = "Congratulations, you've reached Level 2 and unlocked access to Sessions!  See your Dashboard for more details."
      end

      redirect_to :action => :index
    end
  end


  def add_story
    logger.debug "===========#{params.inspect}"
    if params[:user_id].present?
      user = User.find(params[:user_id])
      perspective = user.perspectives.build(:story_type => params[:story_type], 
                                           :story => params[:story],
                                           :anonymous => params[:anonymous] || false)
      perspective.save
      if params[:keyword].present?
        keywords = params[:keyword].split(",")
        keywords.each do |keyword|
          PerspectiveTag.create(:perspective_id => perspective.id,:name => keyword).save
        end
      end
    end
    render :nothing => true
  end
end