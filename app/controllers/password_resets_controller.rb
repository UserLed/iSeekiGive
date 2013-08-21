class PasswordResetsController < ApplicationController
  skip_before_filter :require_login

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    @user.deliver_reset_password_instructions! if @user
    redirect_to root_path, :notice => 'Instructions have been sent to your email.'
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
      redirect_to(login_path, :notice => 'Password was successfully updated.')
    else
      render :action => "edit"
    end
  end
end
