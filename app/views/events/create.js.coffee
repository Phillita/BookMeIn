$('eventForm').modal('hide')
$('eventForm').html("<%= j render partial: 'events/form', locals: { calendar: @calendar, event: Event.new(calendar: @calendar) } %>")
