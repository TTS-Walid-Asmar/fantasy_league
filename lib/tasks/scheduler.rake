desc "Updates status of leagues based on current time"
task :update_league_status => :environment do
  puts "Updating league statuses.."
  leagues = League.where.not(status: "Past")
  leagues.each do |league|
    if league.status = "Upcoming"
      if league.start_time <= Time.now
        league.status = "Live"
        league.save
      end
    else
      if league.start_time <= Time.now + 7.days
        league.status = "Past"
        league.save
      end
    end
  end
  puts "done."
end
