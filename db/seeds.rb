# Department
['Department I', 'Department II', 'Department III'].each do |department|
  Department.create(name: department)
end


# Subject
['Subject I', 'Subject II', 'Subject III'].each do |subject|
  Subject.create(name: subject)
end


# Status
['Waiting for Staff Response', 'Waiting for Customer', 'On Hold', 'Cancelled', 'Completed'].each do |status|
  Status.create(name: status)
end



# Users
User.create(first_name: "Vovan", second_name: "Vovan", username: "vovan", password: '11111111', password_confirmation: "11111111")
User.create(first_name: "Van", second_name: "Van", username: "van", password: '11111111', password_confirmation: "11111111")

