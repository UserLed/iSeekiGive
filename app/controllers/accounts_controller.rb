class AccountsController < UsersController
  before_filter :require_login

  def settings
    @user = current_user
    if request.post?
      @user.password_confirmation = params[:user][:password_confirmation]
      if @user.change_password!(params[:user][:password])
        redirect_to(account_settings_path, :notice => 'Password was successfully updated.')
      end
    end
  end

end