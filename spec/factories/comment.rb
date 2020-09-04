FactoryBot.define do
  factory :comment do
  	work_out_id { 1 }
  	user_id { 1 }
    body { "コメント" }
  end
end
