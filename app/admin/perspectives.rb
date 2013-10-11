ActiveAdmin.register Perspective do
  index do
    selectable_column
    column :id
    column :user
    column :story_type
    column :story
    column "Tags", :sortable => false do |p|
      p.perspective_tags.collect{|t| t.name}.join(", ")
    end
    column :anonymous
    column :created_at
    default_actions
  end
end
