require 'rails_helper'

RSpec.describe Calendar, type: :model do
  describe 'relationships' do
    it { should belong_to :company }
    it { should have_one :api_key }
  end

  describe 'api_token' do
    context 'after_create' do
      it 'should create an api token' do
        calendar = FactoryGirl.build(:calendar)
        expect(calendar.api_key.present?).to be_falsey
        calendar.save
        expect(calendar.api_key.present?).to be_truthy
      end
    end
  end
end
