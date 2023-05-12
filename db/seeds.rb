10.times do |n|
  title = Faker::Games::Pokemon.name
  content = "content"
  expired_at = '2024-01-01 00:00:00'
  status = '未着手'
  priority = 1
  user_id = 102
  Task.create!(title: title,
               content: content,
               expired_at: expired_at,
               status: status,
               priority: priority,
               user_id: user_id
               )
end