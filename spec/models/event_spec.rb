require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'relationships' do
    it { should belong_to :calendar }
  end

  describe 'validations' do
    subject { FactoryGirl.build(:event) }
    it { should validate_presence_of :client_email }
    it { should validate_length_of(:client_email).is_at_most(255) }
    it { should validate_presence_of :calendar_id }
    it { should validate_presence_of :start_dt }
    it { should validate_presence_of :end_dt }
    it { should validate_uniqueness_of :client_email_confirm_token }

    it { should_not validate_presence_of :client_phone }
    it { should_not validate_presence_of :client_comment }

    context 'calendar has validate_phone and validate_comment and validate_name as true' do
      let(:calendar) { FactoryGirl.create(:calendar, validate_phone: true, validate_comment: true, validate_name: true) }
      subject { FactoryGirl.build(:event, calendar: calendar) }

      it { should validate_presence_of :client_phone }
      it { should validate_presence_of :client_comment }
    end

    context 'valid client_email format' do
      it 'should return tru if the client_email address is valid' do
        valid_addresses = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn)
        valid_addresses.each { |valid_address| expect(subject).to allow_value(valid_address).for(:client_email) }
      end

      it 'should reject all invalid client_email addresses' do
        invalid_addresses = %w(user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com)
        invalid_addresses.each { |invalid_address| expect(subject).not_to allow_value(invalid_address).for(:client_email) }
      end
    end
  end

  describe 'create' do
    it 'sends an email' do
      expect { FactoryGirl.create(:event) }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
