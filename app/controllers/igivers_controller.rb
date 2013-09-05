class IgiversController < ApplicationController
  before_filter :require_login, :except => [:new, :create]

  def new
    @igiver = Igiver.new
  end

  def create
    @igiver = Igiver.new(params[:igiver])
    if @igiver.save
      auto_login(@igiver)
      redirect_to @igiver, :notice => "Successfully Signed Up!"
    else
      @password = params[:igiver][:password]
      @password_confirmation = params[:igiver][:password_confirmation]
      render :action  => "new"
    end
  end

  def show
    @igiver = Igiver.find(params[:id])
  end

  def dashboard
    @igiver = Igiver.find(params[:id])
  end
end