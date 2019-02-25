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

class Relationship < ApplicationRecord
end
