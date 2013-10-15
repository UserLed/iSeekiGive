class AccountsController < UsersController
  before_filter :require_login

  def index

  end

  def settings
    @user = current_user
    if request.post?
      @user.password_confirmation = params[:user][:password_confirmation]
      if @user.change_password!(params[:user][:password])
        redirect_to(settings_accounts_path, :notice => 'Password was successfully updated.')
      else

      end
    end
  end

end