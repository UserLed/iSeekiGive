class PublicController < ApplicationController
  def index
    perspectives = Perspective.all
    @good_stories = perspectives.select{|story| story.story_type.eql?("The Good")}
    @bad_stories = perspectives.select{|story| story.story_type.eql?("The Bad")}
    @ugly_stories = perspectives.select{|story| story.story_type.eql?("The Ugly")}
    @users = User.find(perspectives.collect(&:user_id).uniq)
  end

  def signup
    if current_user.present?
      redirect_to current_user
    elsif params[:type]
      session[:user_type] = params[:type]
      @type = session[:user_type]
      render 'signup_form', :layout => false
    end
  end

  def terms_of_service
  end

  def terms_and_condition

  end

  def privacy
  end


  def search_for_user
    term   = params[:tag]
    result = PerspectiveTag.where("name=?", term )
    perspectives  = result.collect(&:perspective_id).uniq unless result.blank?
    user_ids = Perspective.find(perspectives).uniq.collect(&:user_id) unless perspectives.blank? 
    @users = User.find(user_ids) unless user_ids.blank? 
  end



  def get_all_tags
    tags = Tag.where("name LIKE ?", "#{params[:term]}%")
    render :json => tags.collect(&:name)
  end
end
