class Givers::SessionsController < ApplicationController
  before_filter :require_login

  def index
    @giver = Giver.find(params[:giver_id])
  end
end
