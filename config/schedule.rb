every 1.day, :at => '4:30 am' do
  rake "cron:scrape_sites"
  rake "cron:auto_delete"
  rake "twilio:send_text"
end
