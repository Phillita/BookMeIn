$('.modal-form-wrapper').html("<%= j render partial: 'events/form', locals: { event: @event, calendar: @calendar } %>")
