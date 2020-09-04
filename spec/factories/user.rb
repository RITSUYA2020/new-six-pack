FactoryBot.define do
  factory :user do # factory :testuser, class: User do のようにクラスを明示すればモデル名以外のデータも作ることができる
    name { "test" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "testuser" }
  end
end