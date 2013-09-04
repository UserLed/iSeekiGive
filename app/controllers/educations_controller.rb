class EducationsController < ApplicationController
  def update
    @edu = Education.find(params[:id])
    @edu.update_attributes(params[:education])
    @updated_edu = Education.find(params[:id])
    respond_to do |format|
      format.js
      format.html {redirect_to request.referrer}
    end
  end

  def create
    @edu = current_user.educations.new(params[:education])
    @edu.save
    respond_to do |format|
      format.js
      format.html {redirect_to request.referrer}
    end
  end
end