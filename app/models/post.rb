# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  image      :string
#  content    :text
#  user_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  belongs_to :user
end
