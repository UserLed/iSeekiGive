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
    respond_to do |format|
      if params[:type]
        if params[:type] == "iseeker"
          session[:user_type] = "iseeker"
        end
        if params[:type] == "igiver"
          session[:user_type] = "igiver"
        end
        @type = session[:user_type]
        format.html { render 'signin_form', :layout => false}
      else
        format.html
      end
    end
  end
end
