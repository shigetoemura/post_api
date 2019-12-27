class Api::V1::GroupsController < Api::V1::ApplicationController
	before_action :authorize!
	before_action :set_group, only: [:update, :show, :upload_icon, :upload_background_icon]
	before_action :group_member_authorize!, :except => [:create, :index]
	before_action :check_auth_for_update, only: [:update, :upload_icon, :upload_background_icon]

	def create
		group = Group.new(group_params)
		group.save!
		group.build_other_tables_sametimes(current_user.id)
		group_serializer = Api::V1::GroupSerializer.new(group)
		group_member = GroupMember.find_by(group_id: group.id, user_id: current_user.id)
		group_member_serializer = Api::V1::GroupMemberMeSerializer.new(group_member)
		render json: { group: group_serializer.as_json,
			           group_member: group_member_serializer.as_json }
	end

	def update
		if params[:group_params][:title].present?
			@group.title = params[:group_params][:title]
		end
		if params[:group_params][:info].present?
			@group.info = params[:group_params][:info]
		end
		if @group.save!
			serializer = Api::V1::GroupSerializer.new(@group)
			render json: serializer.as_json
		else
			raise ActiveRecord::RecordNotSaved
		end
	end

	def show
		serializer = Api::V1::GroupSerializer.new(@group)
		render json: serializer.as_json
	end

	def upload_icon
		@group.icon = params[:icon]
		@group.save!
		serializer = Api::V1::GroupSerializer.new(@group)
		render json: serializer.as_json
	end

	def upload_background
		@group.background = params[:background]
		@group.save!
		serializer = Api::V1::GroupSerializer.new(@group)
		render json: serializer.as_json
	end

	def index
		query = Group.all
		if params[:query].present?
			query = query.where("title like '%" + params[:query] + "%'")
			.where("info like '%" + params[:query] + "%'")
			.uniq
			.page(params[:page])
			.per(params[:limit])
			.order(updated_at: :desc)
		else
			query = query.page(params[:page]).per(params[:limit]).order(updated_at: :desc)
		end
		serializer = ActiveModel::Serializer::CollectionSerializer.new(
        query,
        serializer: Api::V1::GroupSerializer,
        current_user: current_user
		)
		render json: serializer.as_json
	end

	private
	def group_params
		params.require(:group_params).permit(
			:title,
			:info)
	end

	def set_group
		@group = Group.find(params[:id])
	end

	def check_auth_for_update
  		member = @group.group_members.where(user_id: current_user.id).first
		if member.user_id != current_user.id
			raise Exceptions::NotHaveAuthForUpdateError and return
		end
  	end
end
