class ExperiencesController < ApplicationController
  before_filter :require_login

  def create
    @experience = current_user.experiences.new(params[:experience])
    @experience.save
    
    respond_to do |format|
      format.js
      format.html {redirect_to request.referrer}
    end
  end
  
  def update
    @experience = Experience.find(params[:id])
    @experience.update_attributes(params[:experience])
    @experience = Experience.find(params[:id])
    
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  def destroy
    @experience = Experience.find(params[:id])
    @experience.destroy
  end
end