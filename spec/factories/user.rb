FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Doe'
    sequence(:email) { |n| "email_#{n}@example.com" }
    password 'foobar'
    password_confirmation 'foobar'
  end
end
