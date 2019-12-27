class UserGroup < ApplicationRecord
	validates :group_id, presence: true
	validates :user_id, presence: true

  belongs_to :user, optional: true
  belongs_to :group, optional: true
end
