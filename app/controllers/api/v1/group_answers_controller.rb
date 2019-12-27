class Api::V1::GroupAnswersController < Api::V1::ApplicationController
	before_action :authorize!
	before_action :group_member_authorize!
	before_action :set_group_answer, only: [:show, :update, :destroy, :report]
	before_action :set_favorite, only: [:unfavorite]
	before_action :check_auth_for_update, only: [:update, :upload_icon, :destroy]
	before_action :check_auth_for_favirites, only: [:favorite]
	before_action :check_auth_for_unfavirites, only: [:unfavorite]

	def create
		answer = GroupAnswer.new(group_answer_params)
		answer.group_question_id = params[:group_question_id]
		answer.group_member_id = current_group_member.id
		answer.reply_to_id = params[:group_answer_params][:reply_to_id]
		answer.save!
		answer.build_favirites_count
		serializer = Api::V1::GroupAnswerSerializer.new(answer, current_group_member: current_group_member)
        render json: serializer.as_json
	end

	def show
		serializer = Api::V1::GroupAnswerSerializer.new(@answer, current_group_member: current_group_member)
		render json: serializer.as_json
	end

	def index
		answers = GroupAnswer.where(group_question_id: params[:group_question_id]).page(params[:page]).per(params[:limit]).order(updated_at: :desc)
		serializer = ActiveModel::Serializer::CollectionSerializer.new(
			answers,
			serializer: Api::V1::GroupAnswerSerializer,
			current_group_member: current_group_member)
		render json: serializer.as_json
	end

	def update
		if params[:group_answer_params][:text].present?
			@answer.text = params[:group_answer_params][:text]
		end
		if @answer.save
			serializer = Api::V1::GroupAnswerSerializer.new(@answer, current_group_member: current_group_member)
			render json: serializer.as_json
		else
			raise ActiveRecord::RecordNotSaved
		end
	end

	def upload_icon
		@answer.icon = params[:icon]
		if @answer.save
			serializer = Api::V1::GroupAnswerSerializer.new(@answer, current_group_member: current_group_member)
			render json: serializer.as_json
		else
			raise ActiveRecord::RecordNotSaved
		end
	end

	def destroy
		if @answer.destroy
			render json: { message: "success" }
		else
			raise ActiveRecord::RecordNotSaved
		end
	end


	def favorite
		favorite = Favorite.create!(favorable: @answer, group_member_id: current_group_member.id)
		next_count = @answer.group_answer_favirites_count.count + 1
		@answer.group_answer_favirites_count.update!(count: next_count)
		serializer = Api::V1::GroupAnswerSerializer.new(@answer, current_group_member: current_group_member)
      	render json: serializer.as_json
	end

	def unfavorite
		@favorite.destroy!
		next_count = @answer.group_answer_favirites_count.count - 1
		@answer.group_answer_favirites_count.update!(count: next_count)
		serializer = Api::V1::GroupAnswerSerializer.new(@answer, current_group_member: current_group_member)
      	render json: serializer.as_json
    end

    def report
    	GroupAnswerReport.create!(group_member_id: current_group_member.id, group_answer_id: @answer.id)
    	render json: { message: 'success' }
    end

	private
	def group_answer_params
		params.require(:group_answer_params).permit(
			:text
			)
	end

	def set_group_answer
		@answer = GroupAnswer.find(params[:id])
	end

	def set_favorite
		@favorite = current_group_member.favorites.where(favorable: @answer).first
	end

	def check_auth_for_update
		if current_group_member.user_id != current_user.id
			raise Exceptions::NotHaveAuthForUpdateError and return
		end
	end

	def check_auth_for_favirites
		if current_group_member.favorites.where(favorable: @answer).present?
			raise Exceptions::AlreadyFavoritesError and return
		end
	end

	def check_auth_for_unfavirites
		if current_group_member.favorites.where(favorable: @answer).blank?
			raise Exceptions::NotFavoritesYetError and return
		end
	end
end
