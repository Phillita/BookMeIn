require 'rails_helper'

RSpec.describe EventMailer, type: :mailer do
  let(:event) { FactoryGirl.create(:event) }

  context 'confirmation_email' do
    let(:mail) { EventMailer.confirmation_email(event) }

    it 'renders the subject' do
      expect(mail.subject).to eq('Confirm Your Appointment')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([event.client_email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['do-not-reply@BookMeIn.com'])
    end

    it 'renders client name' do
      expect(mail.body.encoded).to match(event.client_name)
    end

    it 'renders client appointment start time' do
      expect(mail.body.encoded).to match(event.start_dt.to_formatted_s)
    end

    it 'renders client appointment end time' do
      expect(mail.body.encoded).to match(event.end_dt.to_formatted_s)
    end

    it 'renders confirmation link' do
      expect(mail.body.encoded).to match(confirm_event_url(event.client_email_confirm_token))
    end
  end
end
