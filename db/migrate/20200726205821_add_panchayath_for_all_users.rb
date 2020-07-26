class AddPanchayathForAllUsers < ActiveRecord::Migration[6.0]
  def change
    p = Panchayat.find_by(name: "Ernakulam  District Panchayat")&.id.presence || 1
    User.all.each do |u|
      next if u.panchayat_id.present?

      u.panchayat_id = p
      u.save(touch: false)
    end
  end
end
