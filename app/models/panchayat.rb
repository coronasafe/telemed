class Panchayat < ApplicationRecord
  has_many :contacts
  has_many :users
  belongs_to :district
end
