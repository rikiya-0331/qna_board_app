ActiveAdmin.register User do
  permit_params :email, :name, :password, :password_confirmation, :admin

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :admin
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :name
  filter :admin
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :admin
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
    end
    f.actions
  end

  show do
    attributes_table do
      row :email
      row :name
      row :admin
      row :current_sign_in_at
      row :sign_in_count
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
