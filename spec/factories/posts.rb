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
    image { File.open(File.join(Rails.root, "spec/fixtures/sample.jpeg")) }
    sequence(:content) { |c| "Content #{c}" }
    association :user
  end

  trait :ten_minutes_ago do
    created_at { 10.minutes.ago }
  end

  trait :three_years_ago do
    created_at { 3.years.ago }
  end

  trait :two_hours_ago do
    created_at { 2.hours.ago }
  end

  trait :now do
    created_at { Time.zone.now }
  end
end
