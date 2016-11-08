class DemosController < ApplicationController
	def new
	end

	def create
	  user = User.find_by(email: params[:demos][:email].downcase)
	  if user && user.password == params[:demos][:password]
	  	#Log in the user
	  else
	  	flash.now[:danger] = "Invalid email/password"
	  	render 'new'
	  end
	end

	def destroy
	end
end
