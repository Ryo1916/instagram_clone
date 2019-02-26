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
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  default_scope -> { order(created_at: :desc) }

  mount_uploader :image, ImageUploader

  validates :image, presence: true
  validate  :image_size
  validates :content, allow_blank: true,
                      length: { maximum: 255 }
  validates :user_id, presence: true

  def like(user)
    likes.create(user_id: user_id)
  end

  def unlike(user)
    likes.find_by(user_id: user_id).destroy
  end

  def like?(user)
    liking_users.include?(user)
  end

  private

    def image_size
      errors.add(:image, "should be less than 5MB") if image.size > 5.megabytes
    end
end
