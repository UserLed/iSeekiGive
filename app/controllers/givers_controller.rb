class GiversController < ApplicationController
  before_filter :require_login, :except => [:new, :create]

  def new
    @giver = Giver.new
  end

  def create
    @giver = Giver.new(params[:giver])
    if @giver.save
      auto_login(@giver)
      redirect_to dashboard_giver_path(@giver), :notice => "Successfully Signed Up!"
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

  def display_calendar
    @giver = Giver.find(params[:id])
  end

  def create_schedule
   
    unless params[:time_slots].blank? && params[:id].blank?
      time_slots = params[:time_slots]
      giver = Giver.find(params[:id])

      time_slots.each do |time_slot|
        unless Giver.find(params[:id]).schedules.exists?(:schedule_time => time_slot)
          schedule = Schedule.new
          schedule.giver_id = params[:id]
          schedule.giver_name = giver.full_name
          schedule.seeker_id = current_user.id
          schedule.seeker_name = current_user.full_name
          schedule.schedule_time = time_slot
          schedule.description = params[:description]
          schedule.save
        end
      end
      render :text => :ok
      return
    else
      render :text => "something went wrong"
      return
    end

  end
  
end