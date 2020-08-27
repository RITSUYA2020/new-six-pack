class ChangeWorkOutCommentsToComments < ActiveRecord::Migration[5.2]
  def change
    rename_table :work_out_comments, :comments
  end
end
