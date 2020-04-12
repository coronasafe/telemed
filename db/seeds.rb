%w(Thiruvananthapuram Kollam Pathanamthitta Alappuzha Kottayam Idukki Ernakulam Thrissur Palakkad Malappuram Kozhikode Wayanad Kannur Kasaragod).each do |d|
  District.create!(name: d)
end
district = District.find_by(name: "Ernakulam")
["Aikaranad  Grama Panchayat",
  "Alangad Block Panchayat",
  "Alangad Grama Panchayat",
  "Aluva Municipality",
  "Amballoor  Grama Panchayat",
  "Angamaly  Block Panchayat",
  "Angamaly  Municipality",
  "Arakuzha  Grama Panchayat",
  "Asamannoor  Grama Panchayat",
  "Avoly  Grama Panchayat",
  "Ayavana  Grama Panchayat",
  "Ayyampuzha  Grama Panchayat",
  "Chellanam  Grama Panchayat",
  "Chendamangalam  Grama Panchayat",
  "Chengamanad  Grama Panchayat",
  "Cheranalloor  Grama Panchayat",
  "Chittattukara  Grama Panchayat",
  "Choornikkara  Grama Panchayat",
  "Chottanikkara  Grama Panchayat",
  "Cochin  Corporation",
  "Edakkattuvayal  Grama Panchayat",
  "Edappally  Block Panchayat",
  "Edathala  Grama Panchayat",
  "Edavanakkad  Grama Panchayat",
  "Elanji  Grama Panchayat",
  "Elankunnapuzha  Grama Panchayat",
  "Eloor Municipality",
  "Ernakulam  District Panchayat",
  "Ezhikkara  Grama Panchayat",
  "Kadamakudy  Grama Panchayat",
  "Kadungalloor  Grama Panchayat",
  "Kalady  Grama Panchayat",
  "Kalamassery  Municipality",
  "Kalloorkad  Grama Panchayat",
  "Kanjoor  Grama Panchayat",
  "Karukutty  Grama Panchayat",
  "Karumallur  Grama Panchayat",
  "Kavalangad  Grama Panchayat",
  "Keerampara  Grama Panchayat",
  "Keezhmad  Grama Panchayat",
  "Kizhakkambalam  Grama Panchayat",
  "Koovappady  Block Panchayat",
  "Koovappady  Grama Panchayat",
  "Kothamangalam  Block Panchayat",
  "Kothamangalam  Municipality",
  "Kottappady  Grama Panchayat",
  "Kottuvally  Grama Panchayat",
  "Kumbalam  Grama Panchayat",
  "Kumbalanghi  Grama Panchayat",
  "Kunnathunad  Grama Panchayat",
  "Kunnukara  Grama Panchayat",
  "Kuttampuzha  Grama Panchayat",
  "Kuzhuppilly  Grama Panchayat",
  "MalayattoorNeeleswaram  Grama Panchayat",
  "Maneed  Grama Panchayat",
  "Manjalloor  Grama Panchayat",
  "Manjapra  Grama Panchayat",
  "Maradu  Municipality",
  "Marady  Grama Panchayat",
  "Mazhuvannoor  Grama Panchayat",
  "Mookkannur  Grama Panchayat",
  "Mudakuzha  Grama Panchayat",
  "Mulanthuruthy  Block Panchayat",
  "Mulanthuruthy  Grama Panchayat",
  "Mulavukad  Grama Panchayat",
  "Muvattupuzha  Block Panchayat",
  "Muvattupuzha  Municipality",
  "Narakal  Grama Panchayat",
  "Nayarambalam  Grama Panchayat",
  "Nedumbassery  Grama Panchayat",
  "Nellikuzhi  Grama Panchayat",
  "North Paravur  Municipality",
  "Okkal  Grama Panchayat",
  "Paingottoor  Grama Panchayat",
  "Paipra  Grama Panchayat",
  "Palakuzha  Grama Panchayat",
  "Pallarimangalam  Grama Panchayat",
  "Pallippuram  Grama Panchayat",
  "Palluruthy  Block Panchayat",
  "Pampakuda  Block Panchayat",
  "Pampakuda  Grama Panchayat",
  "Parakkadavu  Block Panchayat",
  "Parakkadavu  Grama Panchayat",
  "Paravur  Block Panchayat",
  "Perumbavoor  Municipality",
  "Pindimana  Grama Panchayat",
  "Poothrikka  Grama Panchayat",
  "Pothanicad  Grama Panchayat",
  "Puthenvelikkara  Grama Panchayat",
  "Ramamangalam  Grama Panchayat",
  "Rayamangalam  Grama Panchayat",
  "Sreemoolanagaram  Grama Panchayat",
  "Thirumarady  Grama Panchayat",
  "Thiruvaniyoor  Grama Panchayat",
  "Thrikkakara Municipality",
  "Thuravoor  Grama Panchayat",
  "Tripunithura  Municipality",
  "Udayamperoor  Grama Panchayat",
  "Vadakkekkara  Grama Panchayat",
  "VadavucodePuthencruz  Grama Panchayat",
  "Vadavucode  Block Panchayat",
  "Valakom  Grama Panchayat",
  "Varappetty  Grama Panchayat",
  "Varapuzha  Grama Panchayat",
  "Vazhakulam  Block Panchayat",
  "Vazhakulam  Grama Panchayat",
  "Vengola  Grama Panchayat",
  "Vengoor  Grama Panchayat",
  "Vypin  Block Panchayat"].each do |d|
  Panchayat.create!(name: d, district_id: district.id)
end

[
  { name: "Pending", color: "white" },
  { name: "Not reachable ", color: "pink" },
  { name: "Review in 3hrs", color: "red" },
  { name: "Review in 8 hrs", color: "orange" },
  { name: "Review in 12 hrs", color: "yellow" },
  { name: "Review Tomorrow", color: "blue" },
  { name: "Review after 3 days", color: "purple" },
  { name: "Specialist advice required", color: "indigo" },
  { name: "Plan for Home Care", color: "green" },
  { name: "Follow up not required", color: "gray" }].each do |d|
  Action.create!(name: d[:name], color: d[:color])
end

["Fever", "High Grade Fever", "Sore Throat", "Breathlessness", "Cough", "Diarrhoea", "Rhinitis", "Chest Pain", "Hemoptysis", "Cyanosis", "Drowsiness", "ILI with Red flag Signs", "Hypotension", "Others"].each do |d|
  Symptom.create!(name: d)


  ["Uncontrolled diabetes mellitus", "Hypertension", "Heart disease",
    "Lung disease", "Liver disease", "Kidney disease", "cancer",
    "Immunocompromised", "Autoimmune diseases", "Pregnant", ">60years", "Long term steroid use", "Others"].each do |c|
    Comorbidity.create!(name: c)
  end
end