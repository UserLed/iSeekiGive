class Givers::SessionsController < ApplicationController
  before_filter :require_login

  def index
    @giver = Giver.find(params[:giver_id])
  end

  def inbox
  	@messages = Message.where('from_id=? OR to_id=?',current_user.id,current_user.id).group("uid")
  end

  def new_message
  	require 'securerandom'

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
  			redirect_to inbox_giver_sessions_path(current_user), :notice => "Reply was successful"
  			return
  		else
  			render 'show_message'
  		end
  	end
  end

end
