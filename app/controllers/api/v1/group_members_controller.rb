class Api::V1::GroupMembersController < Api::V1::ApplicationController
	before_action :authorize!
	before_action :group_member_authorize!, :except => [:create]
	before_action :set_group_member, only: [:report, :destroy]
	before_action :check_auth_for_update, only: [:update, :destroy, :upload_icon]

	def create
		group_member = GroupMember.new()
		group_member.group_id = params[:group_id]
		group_member.user_id = current_user.id
		group_member.save!
		group_member.build_group_member_info_with_default_info(current_user.id, group_member.group_id)
		serializer = Api::V1::GroupMemberMESerializer.new(group_member)
		render json: serializer.as_json
 	end

 	def update
 		group_member_info = @group_member.group_member_info
 		if params[:group_member_params][:name]
 			group_member_info.name = params[:group_member_params][:name]
 		end
 		if group_member_info.save
 			serializer = Api::V1::GroupMemberSerializer.new(@group_member)
 			render json: serializer.as_json
 		else
 			raise ActiveRecord::RecordNotSaved
 		end
 	end

 	def upload_icon
 		group_member_info = @group_member.group_member_info
 		group_member_info[:icon] = params[:icon]
 		if group_member_info.save
 			serializer = Api::V1::GroupMemberSerializer.new(@group_member)
 			render json: serializer.as_json
 		else
 			raise ActiveRecord::RecordNotSaved
 		end
 	end

 	def destroy
 		@group_member = GroupMember.find(params[:id])
 		if @group_member.destroy
 			render json: { message: "success" }
 		else
 			raise ActiveRecord::RecordNotSaved
 		end
 	end

 	def report
 		GroupMemberReport.create!(group_member_id: current_group_member.id, reported_member_id: @group_member)
 		render json: { message: "success"}
 	end

 	def follow
 		current_group_member.follow(@group_member)
 		serializer = Api::V1::GroupMemberSerializer.new(@group_member, current_group_member: current_group_member)
 		render json: serializer.as_json
 	end

 	def unfollow
 		current_group_member.unfollow(@group_member)
 		serializer = Api::V1::GroupMemberSerializer.new(@group_member, current_group_member: current_group_member)
 		render json: serializer.as_json
 	end

 	private
 	def group_member_params
 		params.require(:group_member_params).permit(
 			:name)
 	end

 	def set_group_member
 		@group_member = GroupMember.find(params[:id])
 	end

 	def check_auth_for_update
 		if @group_member.id != current_group_member.id
 			raise Exceptions::NotHaveAuthForUpdateError and return
 		end
 	end
end
