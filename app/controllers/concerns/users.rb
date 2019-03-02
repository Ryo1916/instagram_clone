module Users
  extend ActiveSupport::Concern

  def get_users(input_words)
    if input_words
      User.where('username LIKE ?', "%#{input_words}%")
    else
      User
    end
  end
end
