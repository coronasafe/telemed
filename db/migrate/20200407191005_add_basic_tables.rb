class AddBasicTables < ActiveRecord::Migration[6.0]
  def change
    create_table :doctors do |t|
      t.string :name
      t.references :users, null: false, foreign_key: true
      t.timestamps
    end

    create_table :symptoms do |t|
      t.string :name
      t.timestamps
    end

    create_table :actions do |t|
      t.string :name
      t.string :color
      t.timestamps
    end

    add_column :contacts, :alternate_contact, :string
    add_column :contacts, :phc, :string
    add_column :contacts, :health_worker, :string
    add_column :contacts, :number_health_worker, :string
    add_column :contacts, :description, :text
    add_column :contacts, :status, :string
    add_column :contacts, :dob, :date
    add_column :contacts, :old_case_id, :string
    add_column :contacts, :consultation_type, :string
    add_column :contacts, :source, :string

    add_reference :contacts, :assigned_to, index: true

    remove_column :contacts, :willing_to_pay, :string
    remove_column :contacts, :ration_type, :string
    remove_column :contacts, :feedback, :string
    remove_column :contacts, :number_of_family_members, :string
    remove_column :contacts, :date_of_contact, :string
    remove_column :contacts, :tracking_type, :string


    create_table :consultations do |t|
      t.text :reason_for_calling
      t.text :other_details
      t.string :current_status
      t.string :category
      t.boolean :antenatal, default: :false
      t.boolean :quarantined, default: :false
      t.date :quarantined_on
      t.boolean :endemic, default: :false
      t.integer :family_members_count
      t.integer :elderly
      t.integer :comorbidities
      t.boolean :prescription_given
      t.text :notes
      t.string :tested
      t.date :sample_taken_on
      t.references :actions, index: true
      t.string :shift_from
      t.string :shift_to
      t.string :reason
      t.string :string
      t.date :surveillance
      t.references :contacts, index: true
      t.timestamps
    end

    create_table :consultation_symptom do |t|
      t.references :consultations, index: true
      t.references :symptoms
    end
  end
end
