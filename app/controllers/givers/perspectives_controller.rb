class Givers::PerspectivesController < ApplicationController
  before_filter :require_login

  def index
    @giver = Giver.find(params[:giver_id])
  end

  def game_1
    @giver = Giver.find(params[:giver_id])
  end
end