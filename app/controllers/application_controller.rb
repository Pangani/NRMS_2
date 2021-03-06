class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  	def current_child=(child)
		session[:child_id] = child.id
		@child = child
	end

	def current_child
		return @child if @child && @child.id == session[:current_child_id]
		@child = Child.find(session[:current_child_id])
	end

	# def current_user=(user)
	# 	session[:current_user_id] = user.id
	# 	@user = user
	# end

	# def current_user
	# 	return @user if @user && @user.id == session[:current_user_id]
	# 	@user = User.find(session[:current_user_id])
	# end
end