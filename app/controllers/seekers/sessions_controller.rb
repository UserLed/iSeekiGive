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


    if (params[:week].present?) && (0< params[:week].to_i) && (53 > params[:week].to_i)
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
      if schedule then
        schedule.destroy
      end
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
    Message.update_messages(params) if request.post? && params[:message_ids].present?
    @messages= Message.inbox(current_user, params)
    @messages_count = @messages.count

  end

  def new_message
    require 'securerandom'
    @to = User.find 10 #might also be giver_id  static set for temp
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
        redirect_to inbox_seeker_sessions_path(current_user), :notice => "message was sent successfully"
        return
      else
        @message = Message.new
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
        redirect_to inbox_seeker_sessions_path(current_user), :notice => "Reply was successful"
        return
      else
        render 'show_message'
      end
    end
  end

  def download
    send_file("#{Rails.root}/public#{params[:file_name]}")
  end
end
