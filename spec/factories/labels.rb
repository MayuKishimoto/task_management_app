FactoryBot.define do
  factory :label do
    name { "ラベル１" }
  end

  factory :second_label, class: Label do
    name { "ラベル２" }
  end

  factory :third_label, class: Label do
    name { "ラベル３" }
  end
end
