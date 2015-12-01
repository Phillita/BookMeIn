require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  describe 'validations' do
    it { should validate_uniqueness_of(:access_token) }
  end
end
