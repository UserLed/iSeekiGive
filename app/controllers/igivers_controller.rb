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
      render :action  => "new"
    end
  end

  def show
    @igiver = Igiver.find(params[:id])
  end
end