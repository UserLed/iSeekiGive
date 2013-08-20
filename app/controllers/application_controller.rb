class ApplicationController < ActionController::Base
  protect_from_forgery

#  def user_class
#    if session[:user_type].present?
#      session[:user_type].capitalize.constantize
#    else
#      User
#    end
#  end
end
