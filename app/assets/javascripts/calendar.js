setupCalendar = function() {
  var timeConstraint = {
      start: $('#calendar').data('businessHoursStart'),
      end: $('#calendar').data('businessHoursEnd'),

      // days of week. an array of zero-based day of week integers (0=Sunday)
      // (Monday-Friday in this example)
      dow: $('#calendar').data('dow')
  };
  $('#calendar').fullCalendar({
			header: {
				left: 'prev next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},
			// defaultDate: '2015-12-12',
			editable: $('#calendar').data('editable'),
			eventLimit: true, // allow "more" link when too many events
      eventOverlap: false,
      views: {
          agenda: {
              eventLimit: 6 // adjust to 6 only for agendaWeek/agendaDay
          }
      },
      businessHours: timeConstraint,
			events: '/companies/' + $('#calendar').data('comid') + '/calendars/' + $('#calendar').data('calid') + '/events.json',
      eventRender: function(event, element) {
        if(event.description) {
          element.append('<p>' + event.description + '</p>');
        }
      },

      selectable: true,
      selectHelper: true,
      selectOverlap: false,
      unselectAuto: false,
      selectConstraint: timeConstraint,
      select: function(start, end, jsEvent, view) {
        // example of duration validation
        // var ms = moment(start,"DD/MM/YYYY HH:mm:ss").diff(moment(end,"DD/MM/YYYY HH:mm:ss"));
        // var d = moment.duration(ms);
        // var s = Math.floor(d.asHours()) + moment.utc(ms).format(":mm:ss");

        $('#event_start_dt').val(start.format());
        $('#event_end_dt').val(end.format());
        $('#eventModal').modal('show');
      },
      dayClick: function(date, jsEvent, view) {
        if(view.name === 'month' || view.name === 'basicWeek' || view.name === 'basicDay') {
          // change to day view
          $('#calendar').fullCalendar('gotoDate', date);
          $('#calendar').fullCalendar('changeView', 'agendaDay');
        }
      }
		});
}

// $(document).on('ready', function(event) {
// });

$(document).on('ready page:load', function(event) {
  setupCalendar();
});
