module Posts
  extend ActiveSupport::Concern

  # TODO: 'current_user.feed'が二回出てくることを回避できないか？
  def get_posts(input_words)
    if input_words
      current_user.feed.where('content LIKE ?', "%#{input_words}%")
    else
      current_user.feed
    end
  end
end
