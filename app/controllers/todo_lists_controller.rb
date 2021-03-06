class TodoListsController < ApplicationController
  before_action :set_todo_list, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  before_action :owned_post, only: [:edit, :update, :destroy, :show]

  # GET /todo_lists
  # GET /todo_lists.json
  def index
    @todo_lists = TodoList.where(:user_id => current_user.id)
    @todo_lists = if params[:term]
  TodoList.search_by_title(params[:term])
else
  TodoList.where(:user_id => current_user.id)
end
  end

  # GET /todo_lists/1
  # GET /todo_lists/1.json
  def show
   @todo_lists = TodoList.where(:user_id => current_user.id)
    #@todo_item = if params[:term]
  #TodoList.search(params[:term])
#else
  #TodoList.all
#end
  end

  # GET /todo_lists/new
  def new
    @todo_list = TodoList.new
  end

  # GET /todo_lists/1/edit
  def edit
  end

  # POST /todo_lists
  # POST /todo_lists.json
  def create
    @todo_list = TodoList.new(todo_list_params)
    @todo_list['user_id'] = current_user.id

    respond_to do |format|
      if @todo_list.save
        format.html { redirect_to @todo_list, notice: 'Todo list was successfully created.' }
        format.json { render :show, status: :created, location: @todo_list }
      else
        format.html { render :new }
        format.json { render json: @todo_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todo_lists/1
  # PATCH/PUT /todo_lists/1.json
  def update
    respond_to do |format|
      if @todo_list.update(todo_list_params)
        format.html { redirect_to @todo_list, notice: 'Todo list was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo_list }
      else
        format.html { render :edit }
        format.json { render json: @todo_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todo_lists/1
  # DELETE /todo_lists/1.json
  def destroy
    @todo_list = TodoList.find(params[:id])
    @todo_list.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to todo_lists_url, notice: 'Todo list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  

  private

def owned_post
  unless current_user == @todo_list.user
    flash[:alert] = "That post doesn't belong to you!"
    redirect_to root_path
  end
end
  

  def set_user
  @user = User.find_by(id: params[:id])
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_list
      @todo_list = TodoList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_list_params
      params.require(:todo_list).permit(:title, :description, :id)
    end
end
