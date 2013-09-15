class GiversController < ApplicationController
  before_filter :require_login, :except => [:new, :create]

  def new
    @giver = Giver.new
  end

  def create
    @giver = Giver.new(params[:giver])
    if @giver.save
      auto_login(@giver)
      redirect_to @giver, :notice => "Successfully Signed Up!"
    else
      @password = params[:giver][:password]
      @password_confirmation = params[:giver][:password_confirmation]
      render :action  => "new"
    end
  end

  def update
    @giver = Giver.find(params[:id])

    if @giver.update_attributes(params[:giver])
      redirect_to @giver, :notice => "Sucessfully Updated!"
    else
      render :action  => "show"
    end
  end

  def show
    @giver = Giver.find(params[:id])
  end

  def dashboard
    @giver = Giver.find(params[:id])
  end

  def public_profile
    @giver = Giver.find(params[:id])
  end
end