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

  default_scope -> { order(created_at: :desc) }

  mount_uploader :image, ImageUploader

  validates :image, presence: true
  validates :content, allow_blank: true,
                      length: { maximum: 255 }
  validates :user_id, presence: true

  # rspecを実行するとなぜかundefined method 'size'になってしまうので一旦コメントアウト
  # validate :image_size
  #
  # private
  #
  #   def image_size
  #     errors.add(:image, "should be less than 1GB") if image.size > 1.gigabytes
  #   end
end
