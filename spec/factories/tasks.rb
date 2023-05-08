FactoryBot.define do
  factory :task do
    title { 'タイトル１' }
    content { 'コンテント１' }
    expired_at { '2024-01-01 00:00:00' }
    status { '未着手' }
    priority { 1 }
  end

  factory :second_task, class: Task do
    title { 'タイトル２' }
    content { 'コンテント２' }
    expired_at { '2024-01-02 00:00:00' }
    status { '着手中' }
    priority { 2 }
  end
  
  factory :third_task, class: Task do
    title { 'タイトル３' }
    content { 'コンテント３' }
    expired_at { '2024-01-03 00:00:00' }
    status { '完了' }
    priority { 3 }
  end
end