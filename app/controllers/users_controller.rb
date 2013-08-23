class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:activate, :resend_confirmation]

  def activate
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      auto_login(@user)
      redirect_to @user, :notice => 'User was successfully activated.'
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
