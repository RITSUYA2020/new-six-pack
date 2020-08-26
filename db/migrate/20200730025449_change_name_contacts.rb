class ChangeNameContacts < ActiveRecord::Migration[5.2]
  def change
    change_column_null :contacts, :name, false
  end
end
