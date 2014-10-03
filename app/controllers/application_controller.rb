class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def index 
    @todo = Todo.new
    @box = Box.new
    
  	@box_time = Array.new
    	Box.all.each do |box| 
  		@box_time[box.id] = 0
  	end

  	Todo.all.each do |todo|
  		@box_time[todo.box_id] += (todo.done)? 0 : todo.time
	end

  end

end
