class Seekers::SessionsController < ApplicationController
  before_filter :require_login

  def index
    @seeker = Seeker.find(params[:seeker_id])
  end

  def inbox
  	#@messages= Message.where("sender_id=? OR recipient_id=?", current_user.id, current_user.id)
    @messages= Message.receive_messages(current_user)
    @messages_count = @messages.count
  	@messages = @messages.group("uid")
  end

  def new_message
  	require 'securerandom'

  	@to = Giver.find(params[:giver])

  	if request.post?
  		message = Message.new

  		message.from = params[:from] if params[:from].present?
  		message.sender_id = current_user.id

  		message.to = params[:to] if params[:to].present?
  		message.recipient_id= @to.id

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
  		reply.sender_id = current_user.id

  		reply.to =  (current_user.email.eql?(message.from)) ? message.to : message.from
  		reply.recipient_id = (current_user.id.eql?(message.sender_id)) ? message.recipient_id : message.sender_id

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
