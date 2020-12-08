class TodosController < ApplicationController
  def create
    @todos = Todo.all
    @new_todo = Todo.new(todo_params)
    @new_todo.user_id = current_user.id
    @new_todo.save
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
  end

  private

  def todo_params
    params.require(:todo).permit(:task)
  end
end
