class BillingSettingsController < ApplicationController
  before_filter :require_login

  def new
    respond_to do |format|
      if current_user.billing_setting.present?
        @billing_setting = current_user.billing_setting
        format.html {render :action => 'show'}
      else
        @billing_setting = BillingSetting.new
        format.html
      end
    end
  end

  def create
    if current_user.billing_setting.present?
      @billing_setting = current_user.billing_setting
      @billing_setting.stripe_token = params[:stripe_token]
    else
      @billing_setting = current_user.build_billing_setting(:stripe_token => params[:stripe_token])
    end

    if @billing_setting.save
      redirect_to user_path current_user, :notice => 'Billing Settings Saved.'
    else
      render :action => :new, :alert => 'Sorry! Something is wrong!'
    end

  rescue Stripe::CardError => e
    logger.info "#{e.message}"
    render :action => :new, :alert => 'Something went wrong!'
  end

  def show
    @billing_setting = current_user.billing_setting
  end

  def edit
    respond_to do |format|
      format.html
    end
  end
end
