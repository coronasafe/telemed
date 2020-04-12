class Consultation < ApplicationRecord
  enum consultation_type: { doctor: "doctor", pharmacy: "pharmacy", nursing_need: "nursing_need", palliative_care: "palliative_care", others: "others" }
  enum status: { pending: "pending", called: "called", not_reachable: "not_reachable" }
  enum source: { deoc: "deoc", police: "police", private_hospital: "private_hospital", migrant_project: "migrant_project", medical_practitioner: "medical_practitioner" }
  enum current_status: { high_risk: "high_risk", health_care_personnel: "health_care_personnel", general_public: "general_public", quarantined: "quarantined" }
  enum category: { a: "a", b1: "b1", b2: "b2", c: "c", uncategorized: "uncategorized" }
  enum test_status: { positive: "positive", negative: "negative", awaiting: "awaiting", test_invalid: "test_invalid" }
  enum reason: { admission: "admission", consultation: "consultation", testing: "testing", anc: "anc", care_centre: "care_centre" }
  enum comorbidities: { uncontrolled_diabetes_mellitus: "Uncontrolled diabetes mellitus", hypertension: "Hypertension", heart_disease: "Heart disease",
    lung_disease: "Lung disease", liver_disease: "Liver disease", kidney_disease: "Kidney disease", cancer: "cancer",
    immunocompromised: "Immunocompromised", autoimmune_diseases: "Autoimmune diseases", pregnant: "Pregnant", old: ">60years", long_steroid: "Long term steroid use" }
  # enum transport: { ambulance: "ambulance", own_vehicle: "own_vehicle", others: "others" }

  belongs_to :contact
  belongs_to :doctor, optional: true
  belongs_to :creator, class_name: 'User'
  has_many :consultation_symptoms
  has_many :symptoms, through: :consultation_symptoms
  has_many :consultation_versions
  has_many :followups
  # has_many :actions, through: :followups
  belongs_to :action, optional: :true
  has_many :consultation_comorbidity
  has_many :comorbidities, through: :consultation_comorbidity
end
