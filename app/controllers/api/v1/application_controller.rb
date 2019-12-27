class Api::V1::ApplicationController < ApplicationController
    rescue_from ActionController::BadRequest, with: :error400
    rescue_from ActionController::ParameterMissing, with: :error422
    rescue_from ActiveRecord::RecordNotFound, with: :error404
    rescue_from ActiveRecord::RecordInvalid, with: :error422
    rescue_from ActiveRecord::RecordNotSaved, with: :error422
    rescue_from Exceptions::NotHaveAuthForUpdateError, with: :error400
    rescue_from Exceptions::AlreadyFavoritesError, with: :error400
    rescue_from Exceptions::NotFavoritesYetError, with: :error400

	def authorize!
		return if current_user

		render json: { message: "You do not have right current user permission to view this resources"}, status: :unauthorizeds
	end

	def group_member_authorize!
		return if current_group_member

		render json: { message: 'You do not have right guest permission to view this resources.' }, status: :unauthorized
	end

    def guest_authorize!
        return if current_guest_user
        render json: { message: 'You do not have right guest permission to view this resources.' }, status: :unauthorized
    end

	def current_user
    	User.where(token: bearer_token).first
    end

    def current_group_member
        GroupMember.where(token: group_member_token).first
    end

    def error400(err)
        render status: :bad_request, json: {
            error: {
                messages: [err.message],
                status: 400
            }
        }
    end

    def error404(err)
        render status: :not_found, json:{
            error: {
                message: [err.message],
                status: 404
            }
        }
    end


    def error422(err)
        render status: :unprocessable_entity, json:{
            error: {
                message: [err.message],
                status: 422
            }
        }
    end

    def current_guest_user
        Gestuser.where(token: guest_token).first
    end

    private

    def bearer_token
    	@bearer_token ||= begin
        pattern = /^Bearer /
        header = request.headers['Authorization']
        header.gsub(pattern, '') if header&.match(pattern)
    end
    end

    def guest_token
        @guest_token ||= begin
        header = request.headers['X-Guest-Token']
        header
    end
    end

    def group_member_token
        @group_member_token ||= begin
        header = request.headers['X-Group-Member-Token']
        header
    	end
    end
end