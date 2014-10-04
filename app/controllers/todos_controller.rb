class TodosController < ApplicationController
  before_action :authenticate_user!, :set_todo, only: [:show, :edit, :update, :destroy]

  # GET /todos
  # GET /todos.json
  def index
    @todos = Todo.where(user_id: current_user.id)
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(todo_params)
    @todo.user_id = current_user.id
    @todos = Todo.where(user_id: current_user.id, box_id: @todo.box_id).order("done DESC")
    @boxes = Box.where(user_id: current_user.id)

    respond_to do |format|
      if (@todo.user_id == current_user.id) then
        if @todo.save
          format.html { render "/boxes/getTodos.html.erb", layout: false }
          format.json { render :show, status: :created, location: @todo }
        else
          format.html { render :new }
          format.json { render json: @todo.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    @todos = Todo.where(user_id: current_user.id, box_id: @todo.box_id).order("done DESC")
    @boxes = Box.where(user_id: current_user.id)
    
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { render "/boxes/getTodos.html.erb", layout: false }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to todos_url, notice: 'Todo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_params
      params.require(:todo).permit(:name, :description, :time, :box_id, :done)
    end
end
