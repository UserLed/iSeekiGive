class EducationsController < ApplicationController
  before_filter :require_login

  def create
    @education = current_user.educations.new(params[:education])
    @education.save
    respond_to do |format|
      format.js
      format.html {redirect_to request.referrer}
    end
  end

  def update
    @education = Education.find(params[:id])
    @education.update_attributes(params[:education])
    @education = Education.find(params[:id])
    respond_to do |format|
      format.js
      format.html {redirect_to request.referrer}
    end
  end

  def destroy
    @education = Education.find(params[:id])
    @education.destroy
  end
end