class Consultation < ApplicationRecord
  enum consultation_type: { doctor: "doctor", pharmacy: "pharmacy", nursing_need: "nursing_need", palliative_care: "palliative_care", others: "others" }
  enum status: { pending: "pending", called: "called", not_reachable: "not_reachable" }
  enum source: { deoc: "deoc", police: "police", private_hospital: "private_hospital", migrant_project: "migrant_project", medical_practitioner: "medical_practitioner" }
  enum current_status: { high_risk: "high_risk", health_care_personnel: "health_care_personnel", general_public: "general_public" }
  enum category: { a: "a", b1: "b1", b2: "b2", c: "c", uncategorized: "uncategorized" }
  # enum transport: { ambulance: "ambulance", own_vehicle: "own_vehicle", others: "others" }

  belongs_to :contact
  belongs_to :doctor, optional: true
  belongs_to :creator, class_name: 'User'
  has_many :consultation_symptoms
  has_many :symptoms, through: :consultation_symptoms
  has_many :consultation_versions
end
