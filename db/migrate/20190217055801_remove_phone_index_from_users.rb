class RemovePhoneIndexFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_index :users, column: :phone
  end
end
