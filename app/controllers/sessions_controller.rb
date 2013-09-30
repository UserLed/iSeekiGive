class SessionsController < ApplicationController
  def new
    #reset_session
    session.delete(:user_type)
    session.delete(:social_type)
    
    @user = User.new
    if current_user.present?
      redirect_to current_user
    end
  end

  def create
    if @user = login(params[:email], params[:password], params[:remember])
      if @user.seeker?
        redirect_to seeker_perspectives_path(@user)
      else
        redirect_to dashboard_giver_path(@user)
      end
    else
      flash[:alert] = "Invalid email or password."
      render :action => "new"
    end
  end

  def destroy
    reset_session
    logout
    redirect_to(root_path, :notice => 'Logged out!')
  end
end
