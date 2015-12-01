class Company < ActiveRecord::Base
  has_many :users
  has_many :calendars
  has_many :api_keys, through: :calendars
end
