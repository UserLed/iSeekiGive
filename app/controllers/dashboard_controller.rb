class DashboardController < ApplicationController
  before_filter :require_login

  def index
    @user = current_user
  end

  def profile
    @user = current_user
  end

  def experience_and_education
    @user = current_user
  end

  def perspectives
    @user = current_user
  end
end