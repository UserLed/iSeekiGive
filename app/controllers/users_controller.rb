class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def activate
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      redirect_to(login_path, :notice => 'User was successfully activated.')
    else
      not_authenticated
    end
  end

  def resend_confirmation
    @user = User.find(params[:id])
    @user.resend_activation_email!
    redirect_to request.referrer, :notice => "Please check your email to activate your account!"
  end
end
