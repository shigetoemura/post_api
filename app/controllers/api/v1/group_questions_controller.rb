class Api::V1::GroupQuestionsController < Api::V1::ApplicationController
	before_action :authorize!, except: [:guest_timeline]
	before_action :group_member_authorize!, except: [:guest_timeline]
	before_action :guest_authorize!, only: [:guest_timeline]
	before_action :set_question, only: [:update, :show, :destroy]
	before_action :check_auth_for_update, only: [:update, :destroy]

	def create
		question = GroupQuestion.new(question_params)
		question.group_member_id = current_group_member.id
		question.group_id = params[:group_id]
		question.save!
		question.build_answer_member_count
		serializer = Api::V1::GroupQuestionSerializer.new(question, current_group_member: current_group_member)
      	render json: serializer.as_json
	end

	def show
		serializer = Api::V1::GroupQuestionSerializer.new(@question, current_group_member: current_group_member)
		render json: serializer.as_json
	end

	def guest_timeline
		query = GroupQuestion.where(group_id: 1).page(params[:page]).per(params[:limit]).order(updated_at: :desc)
		serializer = ActiveModel::Serializer::CollectionSerializer.new(
			query,
			serializer: Api::V1::GroupQuestionSerializer,
			current_group_member: current_group_member)
		render json: serializer.as_json
	end

	def index
		questions = GroupQuestion.where(group_id: params[:group_id]).page(params[:page]).per(params[:limit]).order(updated_at: :desc)
		serializer = ActiveModel::Serializer::CollectionSerializer.new(
			questions,
			serializer: Api::V1::GroupQuestionSerializer,
			current_group_member: current_group_member
		)
		render json: serializer.as_json
	end

	def update
		if params[:question_params][:title].present?
			@question.title = params[:question_params][:title]
		end
		if @question.save
			serializer = Api::V1::GroupQuestionSerializer.new(@question, current_group_member: current_group_member)
			render json: serializer.as_json
		else
			raise ActiveRecord::RecordNotSaved
		end
	end

	def destroy
  		if @question.destroy
  			render json: {
  				messages: ['Sucsessfully Delete']
  			}
  		else
  			raise ActiveRecord::RecordNotSaved
  		end
  	end



	private
	def question_params
		params.require(:question_params).permit(
        	:title
    	)
	end

	def set_question
		@question = GroupQuestion.find(params[:id])
	end

	def check_auth_for_update
		if @question.group_member_id != current_group_member.id
			raise Exceptions::NotHaveAuthForUpdateError and return
		end
	end
end
