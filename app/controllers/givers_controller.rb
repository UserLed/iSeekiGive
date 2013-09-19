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
    @giver_time_slots = TimeSlot.where("giver_id=?",@giver.id).select("day,time,time_format") 
    @giver_time_slots = @giver_time_slots.collect{|time_slot| [time_slot.day, time_slot.time, time_slot.time_format]}

  end
end