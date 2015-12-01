require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'validations' do
    it { should have_many :users }
    it { should have_many :calendars }
  end
end
