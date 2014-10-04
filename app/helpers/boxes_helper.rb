module BoxesHelper

	def setupBoxTimes
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
