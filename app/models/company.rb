class Company < ActiveRecord::Base
  has_many :users
  has_many :calendars
  # has_many :api_tokens, through: :calendars
end
