require 'rails_helper'

RSpec.describe EventMailer, type: :mailer do
  let(:event) { FactoryGirl.create(:event) }

  describe 'confirmation_email' do
    let(:mail) { EventMailer.confirmation_email(event) }

    it 'renders the subject' do
      expect(mail.subject).to eq('Confirm Your Appointment Email')
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

  describe 'icalendar_event_email' do
    let(:mail) { EventMailer.icalendar_event_email(event) }

    context 'without company name' do
      before(:each) do
        event.company.name = ''
      end

      it 'renders the subject' do
        expect(mail.subject).to eq('Re: Your Appointment')
      end
    end

    context 'with company name' do
      before(:each) do
        event.company.name = 'ABC Corp.'
      end

      it 'renders the subject' do
        expect(mail.subject).to eq('Re: Your Appointment with ABC Corp.')
      end
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

    it 'renders ical attatchment' do
      expect(mail.attachments.size).to eq(1)
      attachment = mail.attachments[0]
      expect(attachment).to be_a_kind_of(Mail::Part)
      expect(attachment.content_type).to eq('application/ics')
      expect(attachment.filename).to eq('appointment.ics')
    end
  end
end
