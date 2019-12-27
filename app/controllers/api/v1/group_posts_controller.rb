class Api::V1::GroupPostsController < Api::V1::ApplicationController
	before_action :authorize!, :except => [:guest_timeline]
	before_action :group_member_authorize!, :except => [:index, :guest_timeline]
	before_action :guest_authorize!, only: [:guest_timeline]
	before_action :set_post, except: [:create, :guest_timeline, :index, :report]
	before_action :set_favorite, only: [:unfavorite]
	before_action :check_auth_for_update, only: [:update, :upload_icon, :destroy]
	before_action :check_auth_for_favorites, only: [:favorite]
	before_action :check_auth_for_unfavorites, only: [:unfavorite]

	def create
		post = GroupPost.new(post_params)
		post.group_id = params[:group_id]
		post.group_member_id = current_group_member.id
		post.reply_to_id = params[:post_params][:reply_to_id]
		post.save!
		post.build_favirites_count
		post.build_replies_count
		post.build_post_reply_notification if post.reply_to_id.present?
		serializer = Api::V1::GroupPostSerializer.new(post, current_group_member: current_group_member)
      	render json: serializer.as_json
	end

	def index
		posts = GroupPost.where(group_id: params[:group_id]).page(params[:page]).per(params[:limit]).order(updated_at: :desc)
		serializer = ActiveModel::Serializer::CollectionSerializer.new(
			posts,
			serializer: Api::V1::GroupPostSerializer,
			current_group_member: current_group_member
		)
		render json: serializer.as_json
	end

	def update
		if params[:post_params][:text].present?
			@post.text = params[:post_params][:text]
		end
		if @post.save
			serializer = Api::V1::GroupPostSerializer.new(@post, current_group_member: current_group_member)
			render json: serializer.as_json
		else
			raise ActiveRecord::RecordNotSaved
		end
	end

	def guest_timeline
		query = GroupPost.where(group_id: 1).page(params[:page]).per(params[:per]).order(updated_at: :desc)
		serializer = ActiveModel::Serializer::CollectionSerializer.new(
			query,
			serializer: Api::V1::GroupPostSerializer
			)
		render json: serializer.as_json
	end

	def upload_icon
		@post.icon = params[:icon]
		if @post.save
			serializer = Api::V1::GroupPostSerializer.new(@post, current_group_member: current_group_member)
			render json: serializer.as_json
		else
			raise ActiveRecord::RecordNotSaved
		end
	end

	def show
		serializer = Api::V1::GroupPostSerializer.new(@post, current_group_member: current_group_member)
		render json: serializer.as_json
	end

	def destroy
		if @post.destroy
			render json: { message: "success" }
		else
			raise ActiveRecord::RecordNotSaved
		end
	end

	def report
		GroupPostReport.create!(group_post_id: @post.id, group_member_id: current_group_member.id)
		render json: { message: 'success' }
	end

	def favorite
			favorite = Favorite.create!(favorable: @post, group_member_id: current_group_member.id)
			next_count = @post.group_post_favirites_count.count + 1
			@post.group_post_favirites_count.update!(count: next_count)
			@post.build_post_favorite_notification(current_group_member.id)
			serializer = Api::V1::GroupPostSerializer.new(@post, current_group_member: current_group_member)
      		render json: serializer.as_json
	end

	def unfavorite
			@favorite.destroy!
			next_count = @post.group_post_favirites_count.count - 1
			@post.group_post_favirites_count.update!(count: next_count)
			serializer = Api::V1::GroupPostSerializer.new(@post, current_group_member: current_group_member)
      		render json: serializer.as_json
	end

	private
	def post_params
		params.require(:post_params).permit(
			:text,
			:group_id)
	end

	def set_post
		@post = GroupPost.find(params[:id])
	end

	def set_favorite
		@favorite = current_group_member.favorites.where(favorable: @post).first
	end

	def check_auth_for_update
		member = current_group_member
		if member.user_id != current_user.id
			raise Exceptions::NotHaveAuthForUpdateError and return
		end
	end

	def check_auth_for_favorites
		if current_group_member.favorites.where(favorable: @post).present?
			raise Exceptions::AlreadyFavoritesError and return
		end
	end

	def check_auth_for_unfavorites
		if current_group_member.favorites.where(favorable: @post).blank?
			raise Exceptions::NotFavoriteYetError and return
		end
	end
end
