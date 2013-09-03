class EducationsController < ApplicationController
  def update
    @edu = Education.find(params[:id])
    @edu.school_name = params[:education][:school_name]
    @edu.degree = params[:education][:degree]
    @edu.field_of_study = params[:education][:field_of_study]
    @edu.start_date = Date.new(params[:education][:start_date].to_i, 1, 1)
    @edu.end_date = Date.new(params[:education][:end_date].to_i, 1, 1)
    @edu.save
    redirect_to request.referrer
  end
end