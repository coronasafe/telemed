class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  enum role: { phone_caller: "phone_caller", panchayat_admin: "panchayat_admin", district_admin: "district_admin", doctor: "doctor", admin: "admin" }
  enum source: { ima: 'ima', deoc: "deoc", police: "police", private_hospital: "private_hospital", migrant_project: "migrant_project", medical_practitioner: "medical_practitioner" }
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :phone_caller
  end

  belongs_to :panchayat, optional: true

  has_many :calls
  has_many :called, through: :calls, source: :contact

  def is_admin?
    ["district_admin", "doctor", "admin"].include?(role)
  end
end
