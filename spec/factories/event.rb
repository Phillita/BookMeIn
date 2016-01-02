FactoryGirl.define do
  factory :event do
    association :calendar
    client_name 'Joe Smith'
    sequence(:client_email) { |n| "email_#{n}@example.com" }
    start_dt Time.zone.now + 2.hours
    end_dt Time.zone.now + 3.hours
    client_phone '555-555-5555'
    client_comment 'Comment'
    client_email_confirm false

    trait :confirm do
      client_email_confirm true
    end

    factory :confirmed_event, traits: %i(confirm)
  end
end
