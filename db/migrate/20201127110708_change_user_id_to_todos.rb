class ChangeUserIdToTodos < ActiveRecord::Migration[5.2]
  def change
    change_column_null :todos, :user_id, false
  end
end
