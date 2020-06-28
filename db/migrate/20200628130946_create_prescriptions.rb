class CreatePrescriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :prescriptions do |t|
      t.string :source
      t.string :scheme
      t.string :supplier
      t.string :delivery_status
      t.jsonb :medicines
      t.references :creator, index: true
      t.references :contact, null: false, foreign_key: true
      t.timestamps
    end
  end
end
