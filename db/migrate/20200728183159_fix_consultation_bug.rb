class FixConsultationBug < ActiveRecord::Migration[6.0]
  def change
    Consultation.where(district_id: nil).each do |c|
      c.district_id = 7
      c.save(touch: false)
    end
  end
end
