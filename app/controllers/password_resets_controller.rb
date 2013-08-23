class PasswordResetsController < ApplicationController
  skip_before_filter :require_login

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_reset_password_instructions!
      flash[:notice] = 'Instructions have been sent to your email.'
      redirect_to root_path
    else
      flash[:alert] = 'Invalid email.'
      render :action => :new
    end
  end

  def edit
    @user = User.load_from_reset_password_token(params[:id])
    @token = params[:id]
    not_authenticated unless @user
  end

  def update
    @token = params[:token]
    @user = User.load_from_reset_password_token(params[:token])
    not_authenticated and return unless @user

    if @user.update_attributes(params[@user.class.name.to_s.downcase])
      flash[:notice] = 'Password was successfully updated.'
      redirect_to login_path
    else
      render :action => "edit"
    end
  end
end
