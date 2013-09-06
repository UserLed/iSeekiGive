class PhoneNumbersController < ApplicationController
  before_filter :require_login

  def new
    @phone_number = PhoneNumber.new
    render :layout => false
  end

  def create
    @phone_number = current_user.build_phone_number(params[:phone_number])

    if @phone_number.save
      redirect_to current_user, :notice => "Phone number successfully added!"
    else
      redirect_to current_user, :alert => "Something went wrong. please try again!"
    end
  end
end