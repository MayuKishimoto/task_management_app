FactoryBot.define do
  factory :user do
    name { "一般ユーザー" }
    email { "ippan@ippan.com" }
    password { "password" }
    admin { false }
  end

  factory :admin_user, class: User do
    name { "管理ユーザー" }
    email { "kanri@kanri.com" }
    password { "password" }
    admin { true }
  end
end
