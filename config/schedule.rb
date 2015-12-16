# Use this file to easily define all of your cron jobs.
#
every :day, at: '10:08pm' do
  rake 'send_email'
end
