# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  name                   :string           default(""), not null
#  username               :string           default(""), not null
#  website                :string           default("")
#  bio                    :text             default("")
#  email                  :string           default(""), not null
#  phone                  :string           default("")
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  gender                 :integer          default("not_specified")
#  provider               :string
#  uid                    :string
#  avatar                 :string
#

require 'rails_helper'

RSpec.describe User, type: :model do
  include CarrierWave::Test::Matchers

  describe "validations test" do
    before do
      @saved_user = User.create(
        name: "Aaron Sumner",
        username: "Aaron",
        email: "aaron@test.abc",
        password: "password"
      )
      @user = FactoryBot.build_stubbed(:user)
    end

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:gender) }
    it { should define_enum_for(:gender) }

    context "valid information" do
      it "is valid with a full name, username, email, and password" do
        expect(@user).to be_valid
      end

      it "is valid avatar format with jpg, jpeg, png" do
        formats = %w[jpeg jpg png]
        formats.each do |format|
          image_path = File.join(Rails.root, "spec/fixtures/sample.#{format}")
          @user.avatar = File.open(image_path)
          expect(@user).to be_valid
        end
      end
    end

    context "invalid information" do
      it "is invalid username format" do
        invalid_usernames = %w[John\ Lennon, Aaron@Sumner]
        invalid_usernames.each do |invalid_username|
          @user.username = invalid_username
          @user.valid?
          expect(@user.errors[:username]).to include("is invalid")
        end
      end

      it "is invalid with a duplicate username" do
        @user.username = "Aaron"
        @user.valid?
        expect(@user.errors[:username]).to include("has already been taken")
      end

      xit "is invalid website format" do
        invalid_websites = %w[example., example..com, example@com]
        invalid_websites.each do |invalid_website|
          @user.website = invalid_website
          @user.valid?
          expect(@user.errors[:website]).to include("is invalid")
        end
      end

      it "is invalid bio that is too long" do
        @user.bio = "a" * 501
        @user.valid?
        expect(@user.errors[:bio]).to include("is too long (maximum is 500 characters)")
      end

      it "is invalid with a duplicate email" do
        @user.email = "aaron@test.abc"
        @user.valid?
        expect(@user.errors[:email]).to include("has already been taken")
      end

      xit "is invalid phone format" do
        invalid_phones = %w[abcdefg, 0907788aagk, %819910375368]
        invalid_phones.each do |invalid_phone|
          @user.phone = invalid_phone
          @user.valid?
          expect(@user.errors[:phone]).to include("is not a number")
        end
      end

      it "is invalid avatar format" do
        image_path = File.join(Rails.root, "spec/fixtures/sample.gif")
        @user.avatar = File.open(image_path)
        expect(@user).not_to be_valid
      end

      it "is invalid avatar size" do
        skip('remove resize_to_fit or change filisize condtion then it will pass')
        image_path = File.join(Rails.root, "spec/fixtures/sample.jpg")
        @user.avatar = File.open(image_path)
        @user.valid?
        expect(@user.errors[:avatar]).to include("should be less than 5MB")
      end

      it "is invalid password that is too short" do
        @user.password = "pass"
        @user.valid?
        expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
      end
    end
  end
end
