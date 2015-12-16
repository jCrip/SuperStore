# Use this file to easily define all of your cron jobs.
#
every 10.minutes do
  rake 'send_email'
end
