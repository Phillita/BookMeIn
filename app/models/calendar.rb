class Calendar < ActiveRecord::Base
  belongs_to :company
  # has_one :api_token
end
