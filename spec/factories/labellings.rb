FactoryBot.define do
  factory :labelling do
    association :user
    association :task
  end
end
