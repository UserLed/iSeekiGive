ActiveAdmin.register Connection do
  actions :all, :except => [:new, :edit]

  index do
    selectable_column
    column :id
    column :user
    column :provider
    column :uid
    column :secret do |cn|
      cn.secret.truncate(20) if cn.secret.present?
    end
    column :token do |cn|
      cn.token.truncate(20) if cn.secret.present?
    end
    column :expires_at
    column :created_at
    column :updated_at
    default_actions
  end
end
