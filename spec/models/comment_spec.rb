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

require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = User.create(
      name: "Aaron Sumner",
      username: "Sumner",
      email: "aaron@test.abc",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    @post = Post.create(
      image: File.open(File.join(Rails.root, "spec/fixtures/download.jpeg")),
      content: "This is the cat, isn't it?",
      user_id: @user.id
    )
    @comment = Comment.new(
      text: "This is my first comment!",
      user_id: @user.id,
      post_id: @post.id
    )
  end

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:post_id) }

  it "is valid with text, user_id, post_id" do
    expect(@comment).to be_valid
  end

  it "is invalid without text" do
    @comment.text = nil
    expect(@comment).not_to be_valid
  end

  it "is invalid with too long text" do
    @comment.text = 'a' * 256
    @comment.valid?
    expect(@comment.errors[:text]).to include('is too long (maximum is 255 characters)')
  end

  it "is invalid without user_id" do
    @comment.user_id = nil
    expect(@comment).not_to be_valid
  end

  it "is invalid without post_id" do
    @comment.post_id = nil
    expect(@comment).not_to be_valid
  end
end
