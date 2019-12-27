class Api::V1::GuestUsersController < Api::V1::ApplicationController
	def create
		gestuser = Gestuser.new()
		if gestuser.save
			serializer = Api::V1::GuestUserSerializer.new(gestuser)
			render json: serializer.as_json
		else
			raise ActionController::BadRequest
		end
	end

end
