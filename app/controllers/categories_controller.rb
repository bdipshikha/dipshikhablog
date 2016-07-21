class CategoriesController < ApplicationController

	def index
		@categories = Category.all
		@posts = Post.order(created_at: :desc).limit(6)
		@posts_month = Post.all.group_by { |post| post.created_at.strftime("%B %Y")}
	end

	def new
		@category = Category.new
	end
	def create
		@category = Category.create(category_params)
		redirect_to '/categories'
	end

	def show
		@category = Category.find(params[:id])
		@posts = Post.where(category_id: @category.id)
		@is_category_creator = session[:user_id] == @category.created_by
		@category_user_name = User.find(@category.created_by).username
		@posts_month = Post.all.group_by { |post| post.created_at.strftime("%B %Y")}
		# @posts_month = Post."group_by_#{month}"(:created_at)
	end

	def archive
		@month = params[:month]
		
		@month.sub!("January ", "01-")
		@month.sub!("February ", "02-")
		@month.sub!("March ", "03-")
		@month.sub!("April ", "04-")
		@month.sub!("May ", "05-")
		@month.sub!("June ", "06-")
		@month.sub!("July ", "07-")
		@month.sub!("August ", "08-")
		@month.sub!("September ", "09-")
		@month.sub!("October ", "10-")
		@month.sub!("November ", "11-")
		@month.sub!("December ", "12-")


		# @posts = Post.where('extract(month  from timestamp) = ?', @month)
		puts "QUERY going to postgres"
		puts Post.where("to_char(created_at, 'MM-YYYY') = ? ", params[:month]).explain
		@posts = Post.where("to_char(created_at, 'MM-YYYY') = ? ", params[:month])
		# @posts = Post.where('extract(month  from created_at) = ?', @month)
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		@category.update(category_params)
		redirect_to @category
	end

	def destroy
		@category = Category.find(params[:id])
		@category.destroy
		redirect_to '/categories'
	end

	private
	def category_params
		params.require(:category).permit(:title, :content, :image, :author, :created_by)
	end

end