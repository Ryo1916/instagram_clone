class AddGenderToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :gender, :integer, :after => :phone, default: 0
  end
end
