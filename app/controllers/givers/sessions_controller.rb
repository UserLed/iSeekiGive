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
                               user_time_zone: params[:user_time_zone])
      render :json => params.inspect + @giver.inspect
      return

    end
  end

  def manage_requests
    @giver = Giver.find(params[:giver_id])
  end

  def inbox
    @giver = Giver.find(params[:giver_id])
  end


end
