class EventMailer < ApplicationMailer
  require 'icalendar'
  require 'icalendar/tzinfo'

  def confirmation_email(event)
    @event = event
    mail(to: @event.client_email, subject: 'Confirm Your Appointment Email')
  end

  def icalendar_event_email(event)
    @event = event
    # Create a calendar with an event (standard method)
    cal = Icalendar::Calendar.new

    # tzinfo integration
    # tzid = "America/Chicago"
    # tz = TZInfo::Timezone.get tzid
    # timezone = tz.ical_timezone event_start
    # cal.add_timezone timezone

    # cal.timezone do |t|
    #   t.tzid = "America/Chicago"
    #
    #   t.daylight do |d|
    #     d.tzoffsetfrom = "-0600"
    #     d.tzoffsetto   = "-0500"
    #     d.tzname       = "CDT"
    #     d.dtstart      = "19700308T020000"
    #     d.rrule        = "FREQ=YEARLY;BYMONTH=3;BYDAY=2SU"
    #   end
    #
    #   t.standard do |s|
    #     s.tzoffsetfrom = "-0500"
    #     s.tzoffsetto   = "-0600"
    #     s.tzname       = "CST"
    #     s.dtstart      = "19701101T020000"
    #     s.rrule        = "FREQ=YEARLY;BYMONTH=11;BYDAY=1SU"
    #   end
    # end
    summary = " with #{event.company.name}"
    cal.event do |e|
      e.dtstart = Icalendar::Values::DateTime.new(event.start_dt)
      e.dtend = Icalendar::Values::DateTime.new(event.end_dt)
      e.summary     = "Appointment#{summary unless event.company.name.blank?}"
      e.description = event.client_comment
      e.ip_class    = 'PRIVATE'

      e.alarm do |a|
        a.action          = 'EMAIL'
        a.description     = event.client_comment # email body (required)
        a.summary         = "Appointment#{summary unless event.company.name.blank?}" # email subject (required)
        a.attendee        = ["mailto:#{event.client_email}"] # one or more email recipients (required)
        # a.append_attendee "mailto:me-three@my-domain.com"
        a.trigger         = '-PT15M' # 15 minutes before
        # a.append_attach   Icalendar::Values::Uri.new "ftp://host.com/novo-procs/felizano.exe", "fmttype" => "application/binary" # email attachments (optional)
      end

      e.alarm do |a|
        a.summary = "Appointment#{summary unless event.company.name.blank?}"
        a.trigger = '-P1DT0H0M0S' # 1 day before
      end
    end

    cal.publish
    attachments['appointment.ics'] = { mime_type: 'application/ics', content: cal.to_ical }
    mail(to: event.client_email, subject: "Re: Your Appointment#{summary unless event.company.name.blank?}")
  end
end
