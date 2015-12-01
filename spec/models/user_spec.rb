require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user) }

  describe 'validations' do
    it 'should be valid' do
      expect(user.valid?).to be_truthy
    end

    it { should validate_presence_of :first_name }
    it { should validate_length_of(:first_name).is_at_most(50) }

    it { should validate_presence_of :last_name }
    it { should validate_length_of(:last_name).is_at_most(50) }

    it { should validate_presence_of :email }
    it { should validate_length_of(:email).is_at_most(255) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }

    context 'valid email format' do
      it 'should return tru if the email address is valid' do
        valid_addresses = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn)
        valid_addresses.each { |valid_address| expect(subject).to allow_value(valid_address).for(:email) }
      end

      it 'should reject all invalid email addresses' do
        invalid_addresses = %w(user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com)
        invalid_addresses.each { |invalid_address| expect(subject).not_to allow_value(invalid_address).for(:email) }
      end
    end
  end

  describe 'name' do
    it 'shoud return the name of the user' do
      expect(user.name).to eq("#{user.first_name} #{user.last_name}")
    end
  end

  describe 'company' do
    context 'after_create' do
      it 'should create a new company' do
        expect(FactoryGirl.create(:user, company_id: nil).company.present?).to be_truthy
      end
    end
  end

  describe 'guest?' do
    it 'should return true if the user has not been saved' do
      expect(user.guest?).to be_truthy
    end

    it 'should return false if the user has been saved' do
      user.save
      expect(user.guest?).to be_falsey
    end
  end
end
