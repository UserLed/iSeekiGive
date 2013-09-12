ActiveAdmin.register Authentication do
  actions :all, :except => [:new, :edit]

  index do
    selectable_column
    column :id
    column :user
    column :provider
    column :uid
    column :secret do |auth|
      auth.secret.truncate(20) if auth.secret.present?
    end
    column :token do |auth|
      auth.token.truncate(20) if auth.secret.present?
    end
    column :expires_at
    column :created_at
    column :updated_at
    default_actions
  end
end
