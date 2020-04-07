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


end
