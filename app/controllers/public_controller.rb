class PublicController < ApplicationController
  def index
  end

  def signup
    respond_to do |format|
      if params[:type]
        if params[:type] == "iseeker"
          session[:user_type] = "iseeker"
        end
        if params[:type] == "igiver"
          session[:user_type] = "igiver"
        end
        @type = session[:user_type]
        format.html { render 'signup_form', :layout => false}
      else
        format.html
      end
    end
  end

  def signin
    reset_session
    respond_to do |format|
      format.html
    end
  end

  def terms_of_service
  end

  def privacy
  end
end
