class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def index 
    @todo = Todo.new
    @box = Box.new
    
  	@box_time = Array.new
    	Box.where(user_id: current_user.id).each do |box| 
  		@box_time[box.id] = 0
  	end

    Todo.where(user_id: current_user.id).each do |todo|
      if (!@box_time[todo.box_id].nil?) then
  	    @box_time[todo.box_id] += (todo.done)? 0 : todo.time
      end
    end

  end

end
