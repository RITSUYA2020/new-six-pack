class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.integer :user_id
      t.integer :room_id
      t.timestamps
    end
    add_index :entries, :user_id
    add_index :entries, :room_id
    # add_index :対象のテーブル名, インデックス対象のカラム名
  end
end
