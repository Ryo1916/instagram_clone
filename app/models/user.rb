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
#

class User < ApplicationRecord
  attr_writer :login

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :lockable, :timeoutable,
         :omniauthable

  enum gender: { not_specified: 0, female: 1, male: 2 }

  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9_\.]*\Z/
  VALID_DOMAIN_REGEX = /\A[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]\.[a-zA-Z]{2,}\Z/
  validates :name, presence: true, case_sensitive: false
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       format: { with: VALID_USERNAME_REGEX }
  validate :validate_username
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: VALID_EMAIL_REGEX }
  validates :website, allow_blank: true,
                      format: { with: VALID_DOMAIN_REGEX }
  validates :bio, allow_blank: true,
                  length: { maximum: 500 }
  validates :phone, allow_blank: true,
                    numericality: { only_integer: true }
  validates :gender, presence: true,
                     inclusion: { in: User.genders.keys }

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
