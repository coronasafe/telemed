class Contact < ApplicationRecord
  enum gender: { male: "male", female: "female", other: "other" }

  belongs_to :panchayat
  has_many :consultations

  attr_accessor :consultation_type
  attr_accessor :source

  has_many :non_medical_reqs
  has_many :medical_reqs

  has_many :calls
  has_many :callees, through: :calls, source: :user

  validate :must_have_valid_number

  def must_have_valid_number
    return if phone.length == 10 && phone.scan(/\D/).empty?

    errors[:base] << "Should be a valid phone number"
  end

  def age_from_dob
    now = Time.zone.now.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

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
