class SeekersController < ApplicationController
  before_filter :require_login, :except => [:new, :create]

  def new
    @seeker = Seeker.new
  end

  def create
    @seeker = Seeker.new(params[:seeker])
    if @seeker.save
      auto_login(@seeker)
      redirect_to seeker_perspectives_path(@seeker), :notice => "Successfully Signed Up!"
    else
      @password = params[:seeker][:password]
      @password_confirmation = params[:seeker][:password_confirmation]
      render :action  => "new"
    end
  end

  def update
    @seeker = Seeker.find(params[:id])

    if @seeker.update_attributes(params[:seeker])
      redirect_to @seeker, :notice => "Sucessfully Updated!"
    else
      render :action  => "show"
    end
  end

  def show
    @seeker = Seeker.find(params[:id])
  end

  def dashboard
    @seeker = Seeker.find(params[:id])
  end

  def buy_points
    @seeker = Seeker.find(params[:id])
  end

  def pay_for_points
    @seeker = Seeker.find(current_user)
    if request.post?
      @amount = params[:amount]
      if @seeker.billing_setting.present?
        # Billing information is present
        @transaction = @seeker.billing_setting.transaction(@amount, 'deduct')
        Payment.create(:transaction_id => @transaction.id, :amount => @amount, :paid => @transaction.paid, :status => 'pending', :user_id => @seeker.id)
        redirect_to buy_points_seeker_path(current_user), notice: "Successfully bought points."
        return
      else
        # === Client's Billing Setting not present
        logger.debug "### Seeker's(#{@seeker}) billing information is not present."
        redirect_to new_seeker_billing_setting_path(current_user), notice: "Billing Information Required."
        return
      end
    end
  end

end