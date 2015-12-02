setupCalendar = function() {
  $('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},
			// defaultDate: '2015-12-12',
			editable: true,
			eventLimit: true, // allow "more" link when too many events
      eventOverlap: false,
      views: {
          agenda: {
              eventLimit: 6 // adjust to 6 only for agendaWeek/agendaDay
          }
      },
      businessHours: {
          start: '08:00', // a start time (10am in this example)
          end: '17:00', // an end time (6pm in this example)

          // days of week. an array of zero-based day of week integers (0=Sunday)
          // (Monday-Friday in this example)
          dow: [ 1, 2, 3, 4, 5 ]
      },
			events: [
				{
					title: 'All Day Event',
					start: moment().format('YYYY-MM-DD'),
          source: {}, // This is where the object from the db can go
          description: 'CUSTOM' // Not standard, will not be displayed by default
				},
				{
					title: 'Long Event',
					start: '2015-12-07',
					end: '2015-12-10'
				},
				{
					id: 999,
					title: 'Repeating Event',
					start: '2015-12-09T16:00:00'
				},
				{
					id: 999,
					title: 'Repeating Event',
					start: '2015-12-16T16:00:00'
				},
				{
					title: 'Conference',
					start: '2015-12-11',
					end: '2015-12-13'
				},
				{
					title: 'Meeting',
					start: '2015-12-12T10:30:00',
					end: '2015-12-12T12:30:00'
				},
				{
					title: 'Lunch',
					start: '2015-12-12T12:00:00'
				},
				{
					title: 'Meeting',
					start: '2015-12-12T14:30:00'
				},
				{
					title: 'Happy Hour',
					start: '2015-12-12T17:30:00'
				},
				{
					title: 'Dinner',
					start: '2015-12-12T20:00:00'
				},
				{
					title: 'Birthday Party',
					start: '2015-12-13T07:00:00'
				},
				{
					title: 'Click for Google',
					url: 'http://google.com/',
					start: '2015-12-28'
				}
			],
      eventRender: function(event, element) {
        if(event.description) {
          element.append('<p>' + event.description + '</p>');
        }
      }
		});
}

// $(document).on('ready', function(event) {
// });

$(document).on('ready page:load', function(event) {
  setupCalendar();
});
