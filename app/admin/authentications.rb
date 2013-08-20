ActiveAdmin.register Authentication do
  config.per_page = 50

  actions :all, :except => [:new, :edit]
end
