# == Schema Information
#
# Table name: likes
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  post_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @user = User.create(
      name: "Aaron Sumner",
      username: "Aaron",
      email: "aaron@test.abc",
      password: "password"
    )
    @post = Post.create(
      image: File.open(File.join(Rails.root, "spec/fixtures/download.jpeg")),
      content: "This is the cat, isn't it?",
      user_id: @user.id
    )
    @like = Like.new(user_id: @user.id,
                     post_id: @post.id)
  end

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:post_id) }

  it "is invalid without user_id" do
    @like.user_id = nil
    expect(@like).not_to be_valid
  end

  it "is invalid without post_id" do
    @like.post_id = nil
    expect(@like).not_to be_valid
  end
end
