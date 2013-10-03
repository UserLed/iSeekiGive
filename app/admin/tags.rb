ActiveAdmin.register Tag do
  menu :parent => "Profiles"

  index do
    selectable_column
    column :id
    column :user
    column :name
    column :created_at
    default_actions
  end
end
