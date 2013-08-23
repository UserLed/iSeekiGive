class PublicController < ApplicationController
  def index
  end

  def signup
    if current_user.present?
      redirect_to current_user
    elsif params[:type]
      session[:user_type] = params[:type]
      @type = session[:user_type]
      render 'signup_form', :layout => false
    end
  end

  def terms_of_service
  end

  def privacy
  end
end
