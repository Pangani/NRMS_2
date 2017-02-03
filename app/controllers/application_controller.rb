class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

 #  	def current_child=(child)
	# 	session[:current_child_id] = child.id
	# 	@child = child
	# end

	# def current_child
	# 	return @child if @child && @child.id == session[:current_child_id]
	# 	@child = Child.find(session[:current_child_id])
	# end
end