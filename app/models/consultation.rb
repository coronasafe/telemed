class Consultation < ApplicationRecord
  enum consultation_type: { doctor: "doctor", pharmacy: "pharmacy", nursing_need: "nursing_need", palliative_care: "palliative_care", others: "others" }
  enum status: { pending: "pending", called: "called", not_reachable: "not_reachable" }
  enum source: { deoc: "deoc", police: "police", private_hospital: "private_hospital", migrant_project: "migrant_project", medical_practitioner: "medical_practitioner" }

  belongs_to :contact
  belongs_to :doctor, optional: true
  belongs_to :creator, class_name: 'User'
  has_many :consultation_symptoms
  has_many :consultation_versions
end
