# == Schema Information
#
# Table name: comments
#
#  id         :bigint(8)        not null, primary key
#  text       :text
#  user_id    :bigint(8)
#  post_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates_presence_of :user_id
  validates_presence_of :post_id
  validates :text, presence: true,
                   length: { maximum: 255 }
end
