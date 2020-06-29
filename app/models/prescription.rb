class Prescription < ApplicationRecord
  enum source: { direct_call: 'direct_call', telemedicine: 'telemedicine', other: 'other' }
  enum delivery_status: { pending: 'pending', initiated: 'initiated', completed: 'completed', deferred: 'deferred' }

  belongs_to :creator, class_name: 'User'
  belongs_to :contact

  def color
    case delivery_status
      when 'pending'
        'orange'
      when 'initiated'
        'blue'
      when 'deferred'
        'red'
      when 'completed'
        'green'
      else
        'gray'
    end
  end
end
