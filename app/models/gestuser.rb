class Gestuser < ApplicationRecord
	before_validation :assign_token
	validates :token, presence: true

	def assign_token
    	self.token ||= SecureRandom.uuid
  	end
end
