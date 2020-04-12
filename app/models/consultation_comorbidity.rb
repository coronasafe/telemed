class ConsultationComorbidity < ApplicationRecord
  belongs_to :consultation
  belongs_to :comorbidity
end
