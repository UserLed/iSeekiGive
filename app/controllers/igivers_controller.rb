class IgiversController < ApplicationController
  before_filter :require_login, :except => [:new, :create]

  def new
    @user = Igiver.new
  end

  def create
    @user = Igiver.new(params[:igiver])
    if @user.save
      redirect_to root_path, :notice => "Successfully Signed Up!"
    else
      render :action  => "new"
    end
  end
end