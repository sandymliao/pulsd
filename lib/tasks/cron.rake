namespace :cron do
  desc "run scrapers"
  task :scrape_sites => :environment do
    @new_events = []

    tc = TimesCenter.new
    Event.create(tc.events)
    tc.events.each do |tc_event|
      if Event.find_by_name(tc_event[:name].downcase)
      else
        @new_events << Event.create(tc_event)
      end
    end

    sb = StrandBookstore.new
    Event.create(sb.events)
    sb.events.each do |sb_event|
      if Event.find_by_name(sb_event[:name].downcase)
      else
        @new_events << Event.create(sb_event)
      end
    end

    rc = RadioCity.new
    Event.create(rc.events)
    rc.events.each do |rc_event|
      if Event.find_by_name(rc_event[:name].downcase)
      else
        @new_events << Event.create(rc_event)
      end
    end

    msp = MadisonSquarePark.new
    Event.create(msp.events)
    msp.events.each do |msp_event|
      if Event.find_by_name(msp_event[:name].downcase)
      else 
        @new_events << Event.create(msp_event)
      end
    end

    cm = ChelseaMarket.new
    Event.create(cm.events)
    cm.events.each do |cm_event|
      if Event.find_by_name(cm_event[:name].downcase)
      else
        @new_events << Event.create(cm_event)
      end
    end

    nc = NewEvent.create(count: @new_events.count)
  end

  desc "auto-delete past events from database"
  task :auto_delete => :environment do
    Event.all.each do |event|
      next if event.end_date.nil?
      if event.end_date.past?
        event.destroy 
      end
    end
  end
end
