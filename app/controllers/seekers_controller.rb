class SeekersController < ApplicationController
  before_filter :require_login, :except => [:new, :create]

  def new
    @seeker = Seeker.new
  end

  def create
    @seeker = Seeker.new(params[:seeker])
    if @seeker.save
      auto_login(@seeker)
      redirect_to @seeker, :notice => "Successfully Signed Up!"
    else
      @password = params[:seeker][:password]
      @password_confirmation = params[:seeker][:password_confirmation]
      render :action  => "new"
    end
  end

  def show
    @seeker = Seeker.find(params[:id])
  end

  def dashboard
    @seeker = Seeker.find(params[:id])
  end

end