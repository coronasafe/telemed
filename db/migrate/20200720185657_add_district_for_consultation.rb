class AddDistrictForConsultation < ActiveRecord::Migration[6.0]
  def change
    add_reference :consultations, :district, index: true
    add_reference :prescriptions, :district, index: true

    Prescription.reset_column_information
    Consultation.reset_column_information

    Consultation.all.each do |c|
      c.district_id = 7
      c.save(touch: false)
    end

    Prescription.all.each do |c|
      c.district_id = 7
      c.save(touch: false)
    end
  end
end
