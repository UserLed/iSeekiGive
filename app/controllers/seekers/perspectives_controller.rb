class Seekers::PerspectivesController < ApplicationController
  before_filter :require_login

  def index
    @seeker = Seeker.find(params[:seeker_id])
  end

  def schools
    @seeker = Seeker.find(params[:seeker_id])
  end

  def majors
    @seeker = Seeker.find(params[:seeker_id])
  end

  def cities
    @seeker = Seeker.find(params[:seeker_id])
  end

  def functions
    @seeker = Seeker.find(params[:seeker_id])
  end

  def skills
    @seeker = Seeker.find(params[:seeker_id])
  end


end
