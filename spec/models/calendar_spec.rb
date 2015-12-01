require 'rails_helper'

RSpec.describe Calendar, type: :model do
  describe 'validations' do
    it { should belong_to :company }
    it { should have_one :api_key }
  end
end
