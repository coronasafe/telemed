class Prescription < ApplicationRecord

    enum source: { direct_call: "direct_call", telemedicine: "telemedicine", other: "other" }
    enum delivery_status: { pending: "pending", completed: "completed", deferred: "deferred", initiated: "initiated"}

    belongs_to :creator, class_name: 'User'
    belongs_to :contact
end
