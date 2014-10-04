class BoxesController < ApplicationController
  before_action :authenticate_user!, :set_box, :setupBoxTimes, only: [:show, :edit, :update, :destroy]


  # GET /boxes
  # GET /boxes.json
  def index
    @boxes = Box.where(user_id: current_user.id)
  end

  # GET /boxes/1
  # GET /boxes/1.json
  def show
  end

  # GET /boxes/new
  def new
    @box = Box.new
  end

  # GET /boxes/1/edit
  def edit
  end

  # POST /boxes
  # POST /boxes.json
  def create
    @box = Box.new(box_params)
    @box.user_id = current_user.id

    respond_to do |format|
      if @box.save
        format.html { redirect_to "/index", notice: 'Box was successfully created.' }
        format.json { render :show, status: :created, location: @box }
      else
        format.html { render :new }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boxes/1
  # PATCH/PUT /boxes/1.json
  def update
    @boxes = Box.where(user_id: current_user.id)

    respond_to do |format|
      if (@box.user_id == current_user.id) then
        if @box.update(box_params)
          format.html { render :getGridBoxes, notice: 'Box was successfully updated.', layout: false}
          format.json { render :show, status: :ok, location: @box }
          format.js {render :getGridBoxes, layout: false}
        else
          format.html { redirect_to "/index", notice: 'error' }
          format.json { render json: @box.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /boxes/1
  # DELETE /boxes/1.json
  def destroy
    @box.destroy
    respond_to do |format|
      format.html { redirect_to "/index", notice: 'Box was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def getTodos
    @box = Box.find(params[:id])
    @todos = Todo.where(box_id: @box.id).order("done DESC")
    respond_to do |format|
      format.html {render :getTodos, layout: false}
    end
  end

  def getGridBoxes
    @boxes = Box.where(user_id: current_user.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_box
      @box = Box.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def box_params
      params.require(:box).permit(:name, :description, :done, :color, :start_date, :pos_x, :pos_y)
    end

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
