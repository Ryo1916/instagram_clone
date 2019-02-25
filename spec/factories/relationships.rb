# == Schema Information
#
# Table name: relationships
#
#  id          :bigint(8)        not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :relationship do
    follower_id { 1 }
    followed_id { 1 }
  end
end
