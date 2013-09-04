class ExperiencesController < ApplicationController
  def update
    @exp = Experience.find(params[:id])
    @exp.update_attributes(params[:experience])
    @updated_exp = Experience.find(params[:id])
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  def create
    @exp = current_user.experiences.new(params[:experience])
    @exp.save
    respond_to do |format|
      format.js
      format.html {redirect_to request.referrer}
    end
  end
end