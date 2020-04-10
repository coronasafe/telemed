class Followup < ApplicationRecord
  belongs_to :user
  belongs_to :consultation
  belongs_to :action
  belongs_to :completed_by, class_name: 'User', optional: true
end
