ActiveAdmin.register User do
  permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :role, :panchayat_id, :name, :source, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :panchayat
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :panchayat
      f.input :name
      f.input :source, as: :select
      f.input :role, as: :select
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
