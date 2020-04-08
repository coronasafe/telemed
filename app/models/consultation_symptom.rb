class ConsultationSymptom < ApplicationRecord
  belongs_to :consultation
  belongs_to :symptom
end
