class Api::V1::NotificationsController < Api::V1::ApplicationController
	before_action :authorize!
	before_action :group_member_authorize!, only: [:index]

	def index
		notifications = Notification.all
		serializer = ActiveModel::Serializer::CollectionSerializer.new(
			notifications,
			serializer: Api::V1::NotificationSerializer,
			current_group_member: current_group_member)
		render json: serializer.as_json
	end
end
