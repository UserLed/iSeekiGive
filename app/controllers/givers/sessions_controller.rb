class Givers::SessionsController < ApplicationController
  before_filter :require_login

  def index
    @giver = Giver.find(params[:giver_id])
  end
  
  def personal_details
    @giver = Giver.find(params[:giver_id])

    if request.post?
      @giver.update_attributes(session_method: params[:session_method],
        skype_id: params[:skype_id],
        contact_number: params[:contact_number],
        other_contact_details: params[:other_contact_details],
        user_time_zone: params[:user_time_zone][:time_zone])
      redirect_to giver_sessions_path(current_user), :notice => "Personal details have been updated"

      #render :json => params.inspect + @giver.inspect
      return

    end
  end

  def manage_requests
    @this_week = Date.today.strftime("%U").to_i
    @prev_week = @this_week-1 
    @next_week = @this_week+1
    @giver = Giver.find(params[:giver_id]) 
    
    if (params[:week].present?) && (0< params[:week].to_i) && (53 > params[:week].to_i )
      target_week = params[:week].to_i
      @interval = (@this_week - target_week) * 7
      @prev_week = target_week-1 
      @next_week = target_week+1
      @giver_schedules = @giver.schedules.where("created_at BETWEEN ? AND  ?", @interval.days.ago.beginning_of_week, @interval.days.ago.end_of_week)

    else
      @giver_schedules = @giver.schedules.where("created_at BETWEEN ? AND ?", Date.today.beginning_of_week, Date.today.end_of_week)
    end

  end

  def session_request_reject
    interval = ((Date.today.strftime("%U").to_i - params[:week].to_i)) * 7

    unless params[:id].nil?
      schedule = Schedule.find(params[:id])
      if schedule then schedule.destroy end
    end
    if params[:week].present?
      @giver_schedules = current_user.schedules.where("created_at BETWEEN ? AND ?", interval.days.ago.beginning_of_week, interval.days.ago.end_of_week)
    else
      @giver_schedules = current_user.schedules.where("created_at BETWEEN ? AND ?", Date.today.beginning_of_week, Date.today.end_of_week)
    end

    respond_to do |format|
      format.js
    end
  end

  def session_request_accept
    interval = ((Date.today.strftime("%U").to_i - params[:week].to_i)) * 7

    unless params[:id].nil?
      schedule = Schedule.find(params[:id])
      if schedule then schedule.update_column(:status, "accepted") end
    end
    if params[:week].present?
      @giver_schedules = current_user.schedules.where("created_at BETWEEN ? AND ?", interval.days.ago.beginning_of_week, interval.days.ago.end_of_week)
    else
      @giver_schedules = current_user.schedules.where("created_at BETWEEN ? AND ?", Date.today.beginning_of_week, Date.today.end_of_week)
    end

    respond_to do |format|
      format.js
    end
  end


  def inbox
    Message.update_messages(params) if request.post? && params[:message_ids].present?
    @messages= Message.inbox(current_user, params)
    @messages_count = @messages.count
  end

  def new_message
    require 'securerandom'
    @to = current_user #might also be seeker_id   when use this function then must set seekers id
    if request.post?
      @message = Message.new(params[:message])
      @message.sender_id = current_user.id
      recipient = Message.receive_msg_by_user(@to.id)
      if recipient.empty?
        @message.uid = SecureRandom.uuid
      else
        @message.uid = recipient.first.uid
      end
      if @message.save!
        redirect_to inbox_giver_sessions_path(current_user), :notice => "message was sent successfully"
        return
      else
        @message = Message.new
        render 'new_message'
      end
    end

  	@to = User.find(params[:giver_id])   #might also be seeker_id
  	
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
	  		redirect_to inbox_giver_sessions_path(current_user), :notice => "message was sent successfully"
	  		return
	  	else
	  		render 'new_message'
	  	end
    end

  end


  def show_message
    @messages = Message.where('uid=? AND (recipient_id = ? OR sender_id = ?)', params[:uid], current_user.id, current_user.id)
    @reply = Message.new
    if request.post?
      message = @messages.first
      @reply = Message.new(params[:message])
      @reply.sender_id = current_user.id
      @reply.recipient_id = (current_user.id.eql?(message.sender_id)) ? message.recipient_id : message.sender_id
      @reply.uid = message.uid

      if @reply.save!
        redirect_to inbox_giver_sessions_path(current_user), :notice => "Reply was successful"
        return
      else
        render 'show_message'
      end
    end
  end


  def time_slot_save

    existing_time_slots = current_user.time_slots
    unless existing_time_slots.blank?
      existing_time_slots.destroy_all
    end
    time_slots = params[:time_slots]
    unless time_slots.nil?
      time_slots = time_slots.collect { |slot| slot.split("_") }

      time_slots.each do |slot|
        tmp_slot = TimeSlot.new
        tmp_slot.giver_id = current_user.id
        tmp_slot.day = slot[0]
        tmp_slot.time = slot[1]
        tmp_slot.time_format = slot[2]
        tmp_slot.save
      end

      render :nothing => true
      return
    end
    render :nothing => true
  end


  def reject_schedule
    logger.debug "#{params.inspect}"
    if current_user.schedules.exists?(:schedule_time => params[:schedule])
      rejected_schedule = current_user.schedules.where(:schedule_time => params[:schedule])

      if rejected_schedule.first.destroy
        render :text => "Schedule deleted"
        return
      else
        render :text => "Something went wrong"
        return
      end

    else
      render :text => "Something went wrong"
    end

  end

  def accept_schedule
    logger.debug "=====#{params.inspect}"
    if current_user.schedules.exists?(:schedule_time => params[:schedule])
      accept_schedule = current_user.schedules.where("schedule_time=?", params[:schedule])
      schedule_id = accept_schedule.first.id

      if is_schedule_time_paid(schedule_id)
        # Schedule time already paid.
      else
        seeker_id = accept_schedule.first.seeker_id
        deduct_amount_from(seeker_id, schedule_id)
        logger.debug "===== Seeker ID: #{seeker_id} - Schedule ID: #{schedule_id} ====="
        accept_schedule.first.update_column(:status, :accepted)
      end

      render :text => :ok
      return
    else
      render :text => "Something went wrong"
    end
  end

  def deduct_amount_from(user_id, schedule_id)
    hourly_rate = 20
    target_user = User.find(user_id)
    if target_user.billing_setting
      # Billing information is present
      logger.debug "===== Seeker's(#{target_user}) Billing information is present ====="

      # Deduct charge from client

      transaction = target_user.billing_setting.transaction(hourly_rate, 'deduct')
      Payment.create(:transaction_id => transaction.id, :schedule_id => schedule_id,
                     :amount => hourly_rate, :status => transaction.paid)
      logger.debug "===== Payment Status: #{transaction.id} - #{transaction.paid} ====="

    else
      # === Client's Billing Setting not present
      logger.debug "===== Seeker's(#{target_user}) Billing information not present ====="
    end
  end

  def is_schedule_time_paid(schedule_id)
    schedule = Schedule.find(schedule_id)
    if schedule && schedule.status == 'accepted'
      logger.debug "===== Schedule - #{schedule_id} is already paid. ====="
      return true
    else
      logger.debug "===== Schedule - #{schedule_id} is not paid. ====="
      return false
    end
  end

  def get_schedule_data
    logger.debug "=====#{params.inspect}"
    data = Schedule.where("schedule_time=?",params[:q]) if params[:q].present?
    render :json => data.first
  end

  def download
    send_file("#{Rails.root}/public#{params[:file_name]}")
  end

end
