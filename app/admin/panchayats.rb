ActiveAdmin.register Panchayat do
  permit_params :name, :district_id

  form do |f|
    f.inputs do
      f.input :name
      f.input :district
    end
    f.actions
  end
end
