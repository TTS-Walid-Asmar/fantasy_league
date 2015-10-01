desc "Updates status of leagues based on current time"
task :update_league_status => :environment do
  puts "Updating league statuses.."
  leagues = League.where.not(status: "Past")
  leagues.each do |league|
    if league.status == "Upcoming"
      if league.start_time <= Time.now
        league.status = "Live"
        league.save
      end
    else
      if league.start_time <= Time.now
        league.process_league
      end
    end
  end
  puts "done."
end

desc "Pulls data form riot esports api and creates leagues associated with the games in thte data."
task :load_fantasy_stats => :environment do
  fant_stat = FantasyStat.new
  fant_stat.load_fantasy_stats
end
