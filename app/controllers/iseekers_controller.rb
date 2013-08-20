class IseekersController < ApplicationController
  before_filter :require_login, :except => [:new, :create]

  def new
    @user = Iseeker.new
  end

  def create
    @user = Iseeker.new(params[:iseeker])
    if @user.save
      redirect_to root_path, :notice => "Successfully Signed Up!"
    else
      render :action  => "new"
    end
  end

  def show
    @user = current_user
  end

  def resend_email
    current_user.resend_activation_email!
    redirect_to current_user, :notice => "Email sent, please check your inbox."
  end
end