# Use this file to easily define all of your cron jobs.
#
every :day, at: '7:30pm' do
  rake 'send_email'
end
