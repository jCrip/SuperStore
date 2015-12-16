# Use this file to easily define all of your cron jobs.
#
every :day, at: '09:55pm' do
  rake 'send_email'
end
