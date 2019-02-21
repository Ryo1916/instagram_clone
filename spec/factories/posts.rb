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

FactoryBot.define do
  factory :post do
    image { "MyString" }
    content { "MyText" }
    user { nil }
  end
end
