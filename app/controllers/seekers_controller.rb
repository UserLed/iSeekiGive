class SeekersController < ApplicationController
  before_filter :require_login, :except => [:new, :create]

  def new
    @seeker = Seeker.new
  end

  def create
    @seeker = Seeker.new(params[:seeker])
    if @seeker.save
      auto_login(@seeker)
      redirect_to seeker_perspectives_path(@seeker), :notice => "Successfully Signed Up!"
    else
      @password = params[:seeker][:password]
      @password_confirmation = params[:seeker][:password_confirmation]
      render :action  => "new"
    end
  end

  def update
    @seeker = Seeker.find(params[:id])

    if @seeker.update_attributes(params[:seeker])
      redirect_to @seeker, :notice => "Sucessfully Updated!"
    else
      render :action  => "show"
    end
  end

  def show
    @seeker = Seeker.find(params[:id])
  end

  def dashboard
    @seeker = Seeker.find(params[:id])
  end

end