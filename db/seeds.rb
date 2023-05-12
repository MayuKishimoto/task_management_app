10.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
  )
  Task.create!(
    title: "タイトル#{n + 1}",
    content: "コンテント#{n + 1}",
    user_id: 102
  )
  Label.create!(
    name: "ラベル#{n + 1}"
  )
end