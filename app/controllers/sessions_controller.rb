class SessionsController < ApplicationController
  def new
    reset_session
    @user = User.new
  end

  def create
    respond_to do |format|
      if @user = login(params[:email], params[:password], params[:remember])
        format.html { redirect_back_or_to @user }
      else
        flash.now[:alert] = "Invalid email or password."
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    reset_session
    logout
    redirect_to(root_path, :notice => 'Logged out!')
  end
end
