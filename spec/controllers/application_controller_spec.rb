require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe 'current_company' do
    context 'logged in user' do
      let(:user) { FactoryGirl.create(:user) }

      before(:each) do
        expect(subject).to receive(:current_user).and_return(user)
      end

      it 'returns a company' do
        expect(subject.current_company).to eq(user.company)
      end
    end

    context 'guest user' do
      it 'returns nil' do
        expect(subject.current_company).to be_nil
      end
    end
  end
end
