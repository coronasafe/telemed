ActiveAdmin.register_page "Dashboard" do
  content do
    h1 "Users"
    para "Use Users to change password for an existing user. Please do not delete anyone as it could create issues"
    para "Dont Add user's from this interface"

    h1 "Actions"
    para "Use actions to add more actions that can be taken on a conslutations"

    h1 "Actions"
    para "Use actions to add more actions that can be taken on a conslutations"

    h1 "Symptoms"
    para "Use symptoms to add more symptoms"

    h1 "Panchayats"
    para "Use Panchayats to add more Panchayats"

    h1 "Stats"
    Consultation.group('created_at::date').count.each do |a|
      para "#{a.first}, #{a.last}"
    end
  end
end
