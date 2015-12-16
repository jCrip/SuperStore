# Use this file to easily define all of your cron jobs.
#
every :day, at: '09:45pm' do
  rake 'send_email'
end
