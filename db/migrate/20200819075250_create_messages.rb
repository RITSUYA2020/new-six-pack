class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :user_id, null: false
      t.integer :room_id, null: false
      t.text :message
      t.timestamps
    end
    add_index :messages, :user_id
    add_index :messages, :room_id
    # add_index :対象のテーブル名, インデックス対象のカラム名
  end
end
