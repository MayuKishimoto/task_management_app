FactoryBot.define do
  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル' }
    content { 'Factoryで作ったデフォルトのコンテント' }
    expired_at { '2023-12-31 00:00:00' }
  end
end