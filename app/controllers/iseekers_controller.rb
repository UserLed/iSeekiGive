class IseekersController < ApplicationController
  before_filter :require_login, :except => [:new, :create]

  def new
    @iseeker = Iseeker.new
  end

  def create
    @iseeker = Iseeker.new(params[:iseeker])
    if @iseeker.save
      auto_login(@iseeker)
      redirect_to @iseeker, :notice => "Successfully Signed Up!"
    else
      render :action  => "new"
    end
  end

  def show
    @iseeker = Iseeker.find(params[:id])
  end

end