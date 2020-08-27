class CreateWorkOuts < ActiveRecord::Migration[5.2]
  def change
    create_table :work_outs do |t|
      t.integer :user_id, null: false
      t.integer :time, null: false
      t.integer :muscle_group, null: false
      t.string :equipment
      t.text :body
      t.integer :effect, null: false
      t.integer :place, null: false
      t.string :before_image_id
      t.string :after_image_id
      t.date :start_time

      t.timestamps
    end
  end
end
