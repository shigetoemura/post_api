class Favorite < ApplicationRecord
	validates :group_member_id, presence: true
	validates :favorable_type, presence: true
	validates :favorable_id, presence: true

	belongs_to :group_member
	belongs_to :favorable, polymorphic: true
	#belongs_to :group_post
    #belongs_to :group_answer
end
