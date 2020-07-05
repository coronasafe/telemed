class AddRemarksForPrescription < ActiveRecord::Migration[6.0]
  def change
    add_column :prescriptions, :remarks, :text
    add_column :prescriptions, :comments, :text
  end
end
