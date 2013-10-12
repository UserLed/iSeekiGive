class AccountsController < UsersController

  def settings
    @user = current_user
    logger.info "Current User :: #{@user.inspect}"
    logger.info "params :: #{params.inspect}"
    if request.post?
      logger.info "Post Req==="
      @user.password_confirmation = params[:user][:password_confirmation]
      # the next line clears the temporary token and updates the password
      if @user.change_password!(params[:user][:password])
        redirect_to(root_path, :notice => 'Password was successfully updated.')
      else
        logger.info "Password not reset"
      end
    end
  end

end