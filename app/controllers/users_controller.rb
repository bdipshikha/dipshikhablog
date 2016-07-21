class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		user = User.create(username: params[:username], password: params[:password])
		session[:user_id] = user.id
		redirect_to categories_path
	end

end