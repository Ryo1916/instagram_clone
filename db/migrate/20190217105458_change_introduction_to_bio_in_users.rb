class ChangeIntroductionToBioInUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :introduction, :bio
  end
end
