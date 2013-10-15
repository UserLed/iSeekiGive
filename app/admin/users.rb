ActiveAdmin.register User do
  actions :all, :except => [:new, :edit]

  filter :first_name
  filter :last_name
  filter :email
  filter :location
  filter :role

  index do
    selectable_column
    column :id
    column :display_name
    column :name
    column :email
    column :location
    column :role
    column :created_at
    column "Manage" do |user|
      link_to "Login", login_admin_user_path(user), :target => "_blank"
    end
    default_actions
  end

  member_action :login do
    @user = User.find(params[:id])
    auto_login @user
    redirect_to dashboard_path
  end
end
