class TodosController < ApplicationController
    def create
        todo = Todo.new(todo_params)
        todo.user_id = current_user.id
        todo.save
        redirect_to request.referer
    end

    def destroy
        todo = Todo.find(params[:id])
        todo.destroy
        redirect_to request.referer
    end

    private

    def todo_params
        params.require(:todo).permit(:task)
    end
end
