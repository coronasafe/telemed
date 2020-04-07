class Contact < ApplicationRecord
  enum gender: { male: "male", female: "female" }
  enum status: { pending: "pending", called: "called", not_reachable: "not_reachable" }
  enum source: { deoc: "deoc", police: "police", private_hospital: "private_hospital", migrant_project: "migrant_project", medical_practitioner: "medical_practitioner" }
  enum consultation_type: { doctor: "doctor", pharmacy: "pharmacy", nursing_need: "nursing_need", palliative_care: "palliative_care", others: "others" }

  belongs_to :panchayat
  has_many :non_medical_reqs
  has_many :medical_reqs

  has_many :calls
  has_many :callees, through: :calls, source: :user

  def self.to_csv
    attributes = %w{name phone house_name ward panchayat to_pay card_color family_members non_medical_needs medical_needs}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.find_each do |contact|
        csv << [
          contact.name,
          contact.phone,
          contact.house_name,
          contact.ward,
          contact.panchayat.name,
          contact.willing_to_pay ? 'Yes' : 'No',
          contact.ration_type,
          contact.number_of_family_members,
          contact.non_medical_reqs.pluck(:requirement_type, :other_needs).map { |req| "Need #{req[0]} (#{req[1]})" }.join(', '),
          contact.medical_reqs.pluck(:requirement_type, :other_needs).map { |req| "Need #{req[0]} (#{req[1]})" }.join(', ')
        ]
      end
    end
  end

  def self.to_non_medical_csv
    attributes = %w{name phone house_name ward panchayat to_pay card_color family_members non_medical_needs}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.find_each do |contact|
        csv << [
          contact.name,
          contact.phone,
          contact.house_name,
          contact.ward,
          contact.panchayat.name,
          contact.willing_to_pay ? 'Yes' : 'No',
          contact.ration_type,
          contact.number_of_family_members,
          contact.non_medical_reqs.pluck(:requirement_type, :other_needs).map { |req| "Need #{req[0]} (#{req[1]})" }.join(', '),
        ]
      end
    end
  end

  def self.to_medical_csv
    attributes = %w{name phone house_name ward panchayat to_pay card_color family_members medical_needs}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.find_each do |contact|
        csv << [
          contact.name,
          contact.phone,
          contact.house_name,
          contact.ward,
          contact.panchayat.name,
          contact.willing_to_pay ? 'Yes' : 'No',
          contact.ration_type,
          contact.number_of_family_members,
          contact.medical_reqs.pluck(:requirement_type, :other_needs).map { |req| "#{req[0]} Medicine (#{req[1]})" }.join(', '),
        ]
      end
    end
  end
end
