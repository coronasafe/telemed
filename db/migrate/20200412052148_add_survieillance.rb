class AddSurvieillance < ActiveRecord::Migration[6.0]
  def change
    create_table :comorbidities do |t|
      t.string :name
      t.timestamps
    end

    create_table :consultation_comorbidities do |t|
      t.references :consultation, index: true
      t.references :comorbidity, index: true
    end

    add_column :consultations, :requires_surveillance, :boolean
    add_column :consultations, :other_comorbidity, :string
  end
end
