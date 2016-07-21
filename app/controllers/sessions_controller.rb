class SessionsController < ApplicationController
	
	def new
	end

	def create
		user = User.find_by(username: params[:username])

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to categories_path
		else
			@error = "username and password are not in system"
			render :new
		end
	end

	def destroy
		reset_session
		redirect_to categories_path :notice => "Logged out"
	end
end