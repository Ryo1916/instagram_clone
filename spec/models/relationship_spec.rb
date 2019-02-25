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

require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @follower = User.create(
      name: "Aaron Sumner",
      username: "Aaron",
      email: "aaron@test.abc",
      password: "password"
    )
    @followed = User.create(
      name: "Walter Backer",
      username: "walter",
      email: "walter@test.abc",
      password: "password"
    )

    @relationship = Relationship.new(follower_id: @follower.id,
                                     followed_id: @followed.id)
  end

  it { should validate_presence_of(:follower_id) }
  it { should validate_presence_of(:followed_id) }

  it "is invalid without follower_id" do
    @relationship.follower_id = nil
    expect(@relationship).not_to be_valid
  end

  it "is invalid without followed_id" do
    @relationship.followed_id = nil
    expect(@relationship).not_to be_valid
  end
end
