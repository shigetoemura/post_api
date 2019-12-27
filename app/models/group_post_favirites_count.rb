class GroupPostFaviritesCount < ApplicationRecord
	validates :group_post_id, presence: true
    validates :count, presence: true
    
    belongs_to :group_post

end
