class AddBasicTables < ActiveRecord::Migration[6.0]
  def change
    create_table :doctors do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
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

    create_table :districts do |t|
      t.string :name
      t.timestamps
    end

    add_column :contacts, :alternate_contact, :string
    add_column :contacts, :phc, :string
    add_column :contacts, :health_worker, :string
    add_column :contacts, :number_health_worker, :string
    add_column :contacts, :description, :text
    add_column :contacts, :dob, :date
    add_column :contacts, :old_case_id, :string
    add_reference :panchayats, :district, index: true

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
      t.string :comorbidities
      t.boolean :prescription_given
      t.text :notes
      t.string :test_status
      t.date :sample_taken_on
      t.references :action, index: true
      t.string :shift_from
      t.string :shift_to
      t.string :reason
      t.string :consultation_type
      t.string :status
      t.string :source
      t.string :surveillance
      t.references :contact, index: true
      t.references :doctor, index: true
      t.references :creator, index: true
      t.timestamps
    end

    create_table :consultation_symptoms do |t|
      t.references :consultation, index: true
      t.references :symptom
    end

    create_table :consultation_versions do |t|
      t.references :consultation, index: true
      t.text :change
      t.references :user, index: true
    end
  end
end
