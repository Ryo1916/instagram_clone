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
#  gender                 :string           default("")
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
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations test" do
    before do
      @saved_user = User.create(name: "Aaron Sumner",
                                username: "Aaron",
                                email: "aaron@test.abc",
                                password: "password")
      @user = User.new(name: "Ringo Starr",
                       username: "Ringo",
                       email: "Starr@beatles.com",
                       password: "i'vegotblistersonmyfinger")
    end

    context "valid information" do
      it "is valid with a full name, username, email, and password" do
        expect(@user).to be_valid
      end
    end

    context "invalid information" do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:username) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:password) }

      it "is invalid username format" do
        invalid_usernames = %w[John\ Lennon, Aaron@Sumner]
        invalid_usernames.each do |invalid_username|
          @user.username = invalid_username
          @user.valid?
          expect(@user.errors[:username]).to include("is invalid")
        end
      end

      it "is invalid with a duplicate username" do
        user = User.new(
          name: "Paul Mccartney",
          username: "Aaron",
          email: "paul@beatles.com",
          password: "oops,sorry",
        )
        user.valid?
        expect(user.errors[:username]).to include("has already been taken")
      end

      it "is invalid website format" do
        invalid_websites = %w[example., example..com, example@com]
        invalid_websites.each do |invalid_website|
          @user.website = invalid_website
          @user.valid?
          expect(@user.errors[:website]).to include("is invalid")
        end
      end

      it "is invalid bio that is too long" do
        @user.bio = "UkdONzL4dIysuv7kWxy4FeSUr34LLvjBdXT17NJkM0IT5heYaRYG5b13SQHRAQ1CT0RSM0d0Ps9mJ4BmgcpEra4JusyvJISyoF4YIX1AK1uXR4lGNbEBJnyNlhAMvFePA56zsSPYLBjESde1oOvOm2Nm94fFexjeyL4mFk5DVmdIkqYESj6O2Q4NKyHsZLbK9QZFzx3SEtHYJIQ4kgWqYZRkeJkWewFamt1XyqUkAU9oVGhIfOirmIINq78q2tSuKIxwf5fzNTp72EULYRTEGNls8Lim5sr5Qo0EE3aazo0inx6dKR89Fg3diS3rJJIPghhJSl0QYuckcrFFOQnUNT4hqtLtXpA3vqvaGcQdOZ5IzhHCFXzB88JPSMQzZxhlCUPZkl9I6mNlzoBlXC2ZoHPeNvEbwyxwIHtBpbr8tJkGiyxOk5opvadEBbQoz1fPkmfDyyEsVCgHX2SdLHQwHZh7APXpgr3fIXPHEX1vqK1718dvljZr!"
        @user.valid?
        expect(@user.errors[:bio]).to include("is too long (maximum is 500 characters)")
      end

      it "is invalid with a duplicate email" do
        user = User.new(
          name: "Jane Samner",
          username: "Jane",
          email: "aaron@test.abc",
          password: "foobar"
        )
        user.valid?
        expect(user.errors[:email]).to include("has already been taken")
      end

      it "is invalid phone format" do
        invalid_phones = %w[abcdefg, 0907788aagk, %819910375368]
        invalid_phones.each do |invalid_phone|
          @user.phone = invalid_phone
          @user.valid?
          expect(@user.errors[:phone]).to include("is not a number")
        end
      end

      it "is invalid password that is too short" do
        user = User.new(password: "pass")
        user.valid?
        expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
      end
    end

  end
end
