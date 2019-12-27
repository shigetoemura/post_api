class Api::V1::SignUpsController < Api::V1::ApplicationController
	def create
      user = User.create!
      user.build_user_group_for_general
      user.build_group_member_for_general(sign_up_user_params[:name])
      serializer = Api::V1::SignUpSerializer.new(user)
      render json: serializer.as_json
  end

    private

    def sign_up_user_params
    	params.require(:sign_up_user_params).permit(
        	:name,
          :device_uuid
    	)
    end

end
