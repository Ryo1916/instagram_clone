# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  name                   :string           default(""), not null
#  username               :string           default(""), not null
#  website                :string           default("")
#  introduction           :text             default("")
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

class User < ApplicationRecord
  attr_writer :login

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :lockable, :timeoutable,
         :omniauthable

  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, case_sensitive: false
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, multiline: true
  validate :validate_username
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: VALID_EMAIL_REGEX }

  def validate_username
    errors.add(:username, :invalid) if User.where(email: username).exists?
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    conditions[:email]&.downcase!
    login = conditions.delete(:login)

    where(conditions.to_hash).where(
      ['lower(username) = :value OR lower(email) = :value',
       { value: login.downcase }]
    ).first
  end
end
