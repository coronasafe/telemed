class AddTimeForAction < ActiveRecord::Migration[6.0]
  class Action < ActiveRecord::Base
  end

  def change
    add_column :actions, :hours, :integer

    Action.reset_column_information

    Action.all.each do |a|
      a.update!(hours: hours(a))
    end
  end

  def hours(action)
    case action
      when "Pending"
        0
      when "Not reachable "
        0
      when "Review in 8 hrs"
        8
      when "Review in 12 hrs"
        12
      when "Review after 3 days"
        72
      when "Specialist advice required"
        0
      when "Plan for Home Care"
        0
      when "Follow up not required"
        0
      when "Review in 3hrs"
        3
      when "Complete"
        0
      when "Review after 24 hrs"
        24
      else
        0
    end
  end
end
