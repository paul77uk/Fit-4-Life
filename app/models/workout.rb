class Workout < ApplicationRecord
  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }
  scope :authenticated_users_workouts, ->(current_user) { where('user_id == ?', current_user) }

  # after_create_commit -> { broadcast_prepend_later_to "workouts" }
  # after_update_commit -> { broadcast_replace_later_to "workouts" }
  # after_destroy_commit -> { broadcast_remove_to "workouts" }
  # Those three callbacks are equivalent to the following single line
  broadcasts_to ->(workout) { "workouts" }, inserts_by: :prepend
  belongs_to :user
end
