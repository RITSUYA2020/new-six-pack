FactoryBot.define do
  factory :work_out do
    user_id { 1 }
    time { 'test' }
    muscle_group { 'abs_core' }
    equipment { 'ヨガマット' }
    body { '腹筋のクイックヒット' }
    effect { 'just_right' }
    place { 'home' }
    before_image_id { nil }
    before_image_id { nil }
    start_time { 20_200_904 }
  end
end
