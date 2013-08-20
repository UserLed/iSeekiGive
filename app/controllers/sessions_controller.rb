class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    respond_to do |format|
      if @user = login(params[:username],params[:password])
        @msg = @user.activated? ? "Login successful." : "Confirmation email sent to you. Please verify email"
        format.html { redirect_back_or_to(@user, :notice => @msg) }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { flash.now[:alert] = "Login failed."; render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    reset_session
    logout
    redirect_to(root_path, :notice => 'Logged out!')
  end
end
