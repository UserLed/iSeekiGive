class ProfileController < ApplicationController
  before_filter :require_login

  def index
    @user = current_user
  end

  def photos
    @user = current_user
  end

  def experience_and_education
    @user = current_user
    @educations = @user.educations
    @experiences = @user.experiences
  end

  def your_keywords_tags
    @user = current_user
    @tags = @user.tags.order("created_at desc").paginate(:page => params[:page], :per_page => 30)
  end
end