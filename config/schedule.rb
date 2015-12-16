# Use this file to easily define all of your cron jobs.
#
every :day, at: '12:15pm' do
  rake 'send_email'
end
