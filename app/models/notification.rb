class Notification < ApplicationRecord
  # スコープ(新着順)
  default_scope -> { order(created_at: :desc) }

  belongs_to :work_out, optional: true # optional: trueはwork_out_idにnilを許容する
  belongs_to :comment, optional: true
  belongs_to :visiter, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true
end
