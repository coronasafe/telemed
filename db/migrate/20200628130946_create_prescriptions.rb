class CreatePrescriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :prescriptions do |t|
      t.string :source
      t.string :scheme
      t.string :supplier
      t.string :delivery_status
      t.jsonb :medicines

      t.timestamps
    end
  end
end
