FactoryGirl.define do
  factory :calendar do
    association :company
    name 'My Calendar'
    business_hours_start '08:00'
    business_hours_end '17:00'
    validate_name false
    validate_phone false
    validate_comment false
  end
end
