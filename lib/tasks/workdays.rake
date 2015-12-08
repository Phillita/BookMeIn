namespace :workdays do
  desc 'Load the days of the week into the workdays table'
  task load: :environment do
    Workday.create(name: 'Sunday')
    Workday.create(name: 'Monday')
    Workday.create(name: 'Tuesday')
    Workday.create(name: 'Wednesday')
    Workday.create(name: 'Thursday')
    Workday.create(name: 'Friday')
    Workday.create(name: 'Saturday')
  end
end
