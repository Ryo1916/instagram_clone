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

require 'rails_helper'

RSpec.describe Post, type: :model do
  include CarrierWave::Test::Matchers

  describe "validations test" do
    before do
      @user = User.create(
        name: "Aaron Sumner",
        username: "Sumner",
        email: "aaron@test.abc",
        password: "dottle-nouveau-pavilion-tights-furze",
      )
      @new_post = FactoryBot.build_stubbed(:post)
    end

    it { should validate_presence_of(:image) }
    it { should validate_presence_of(:user_id) }

    context "valid information" do
      it "is valid with a image, content and user_id" do
        expect(@new_post).to be_valid
      end
    end

    context "invalid information" do
      it "is invalid without image" do
        @new_post.image = nil
        expect(@new_post).not_to be_valid
      end

      it "is invalid image format" do
        image_path = File.join(Rails.root, "spec/fixtures/sample.gif")
        @new_post.image = File.open(image_path)
        expect(@new_post).not_to be_valid
      end

      it "is invalid image size" do
        skip('remove resize_to_fit or change filisize condtion then it will pass')
        image_path = File.join(Rails.root, "spec/fixtures/sample.jpg")
        @new_post.image = File.open(image_path)
        expect(@new_post).not_to be_valid
      end

      it "is invalid with content that is too long" do
        @new_post.content = 'a' * 256
        expect(@new_post).not_to be_valid
      end

      it "is invalid without user_id" do
        @new_post.user_id = nil
        expect(@new_post).not_to be_valid
      end

      it "is ordered by most recent first" do
        post = FactoryBot.create(:post, :now)
        expect(post).to eq Post.first
      end
    end
  end
end
