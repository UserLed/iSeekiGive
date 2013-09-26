class Seekers::SessionsController < ApplicationController
  before_filter :require_login

  def index
    @seeker = Seeker.find(params[:seeker_id])
  end

  def manage_requests
    @this_week = Date.today.strftime("%U").to_i
    @prev_week = @this_week-1 
    @next_week = @this_week+1
    @seeker = Seeker.find(params[:seeker_id]) 

    
    if (params[:week].present?) && (0< params[:week].to_i) && (53 > params[:week].to_i )
      target_week = params[:week].to_i
      @interval = (@this_week - target_week) * 7
      @prev_week = target_week-1 
      @next_week = target_week+1
      @seeker_schedules = @seeker.schedules.where("created_at BETWEEN ? AND  ?", @interval.days.ago.beginning_of_week, @interval.days.ago.end_of_week)

    else
      @seeker_schedules = @seeker.schedules.where("created_at BETWEEN ? AND ?", Date.today.beginning_of_week, Date.today.end_of_week)
    end

  end

  def session_request_reject
    interval = ((Date.today.strftime("%U").to_i - params[:week].to_i)) * 7

    unless params[:id].nil?
      schedule = Schedule.find(params[:id])
      if schedule then schedule.destroy end
    end

    if params[:week].present?
      @seeker_schedules = current_user.schedules.where("created_at BETWEEN ? AND ?", interval.days.ago.beginning_of_week, interval.days.ago.end_of_week)
    else
      @seeker_schedules = current_user.schedules.where("created_at BETWEEN ? AND ?", Date.today.beginning_of_week, Date.today.end_of_week)
    end
    
    respond_to do |format|
      format.js
    end
  end

  def inbox
  	@messages= Message.where("from_id=? OR to_id=?", current_user.id, current_user.id)
  	@messages_count = @messages.count
  	@messages = @messages.group("uid")
  end

  def new_message
  	require 'securerandom'

  	@to = Giver.find(params[:giver])

  	if request.post?
  		message = Message.new

  		message.from = params[:from] if params[:from].present?
  		message.from_id = current_user.id

  		message.to = params[:to] if params[:to].present?
  		message.to_id= @to.id

  		message.subject = params[:subject] if params[:subject].present?
  		message.content = params[:content] if params[:content].present?

  		message.uid = SecureRandom.uuid

	  	if message.save
	  		redirect_to inbox_seeker_sessions_path(current_user), :notice => "message was sent successfully"
	  		return
	  	else
	  		render 'new_message'
	  	end
	end

  end


  def show_message
  	@messages = Message.where('uid=?',params[:uid])
  	
  	if request.post?
  		message = @messages.first
  		reply = Message.new
  		
  		reply.from = current_user.email
  		reply.from_id = current_user.id

  		reply.to =  (current_user.email.eql?(message.from)) ? message.to : message.from
  		reply.to_id = (current_user.id.eql?(message.from_id)) ? message.to_id : message.from_id

  		reply.subject = message.subject
  		reply.content = params[:content] if params[:content].present?

  		reply.uid = message.uid

  		if reply.save
  			redirect_to inbox_seeker_sessions_path(current_user), :notice => "Reply was successful"
  			return
  		else
  			render 'show_message'
      end

  	end
  end

end
