Profile.create!(name: "ExampleUser",
  biography: "Hi Please follow me",
  birthday: "",
  website: "",
  user_id: 1)

29.times do |n|
  name = Faker::Name.last_name
  biography = ""
  birthday = ""
  website = ""
  Profile.create!(name:  name,
    biography: biography,
    birthday: birthday,
    website: website,
    user_id: n+2)
end
