class ExperiencesController < ApplicationController
  def update
    @exp = Experience.find(params[:id])
    @exp.title = params[:experience][:title]
    @exp.company_name = params[:experience][:company_name]
    @exp.start_date = Date.new(params[:experience][:start_date].to_i, 1, 1)
    @exp.end_date = Date.new(params[:experience][:end_date].to_i, 1, 1)
    @exp.save
    redirect_to request.referrer
  end
end