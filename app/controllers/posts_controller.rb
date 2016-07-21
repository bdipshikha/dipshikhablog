class PostsController < ApplicationController

	def new
		@post = Post.new
	end

	def create
		@category = Category.find(params[:category_id])
		@post = @category.posts.create(post_params)
		redirect_to @category
	end

	def show
		@category = Category.find(params[:category_id])
		@post = Post.find(params[:id])
		@is_creator = session[:user_id] == @post.created_by
		@user_name = User.find(@post.created_by).username
		@posts_month = Post.all.group_by { |post| post.created_at.strftime("%B %Y")}
	end

  	def search

  		@query = params[:search]
  		search_condition = "%" + @query + "%"
  		# search_condition = "%" + params[:search] + "%"
  		puts params[:search]

		@results = Post.where("title ILIKE ? OR content ILIKE ? ", search_condition, search_condition)	
	end

	def slideshow
		@posts = Post.order(created_at: :desc)
	end


	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		@post.update(post_params)
		redirect_to category_post_path
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to '/categories'
	end

	private
	def post_params
		params.require(:post).permit(:title, :content, :image, :author, :category_id, :created_by)
	end
end