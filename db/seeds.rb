# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first
players = Player.create([{name: "Bjergson", position: 'mid', score: 20, value: 5000, points_per_game: 22.1},
                        {name: "Dyrus", position: 'top', score: 20, value: 5000, points_per_game: 22.1},
                        {name: "Hai", position: 'mid', score: 20, value: 5000, points_per_game: 22.1},
                        {name: "WildTurtle", position: 'adc', score: 20, value: 5000, points_per_game: 22.1},
                        {name: "Santorin", position: 'jungler', score: 20, value: 5000, points_per_game: 22.1},
                        {name: "Lemonation", position: 'support', score: 20, value: 5000, points_per_game: 22.1},
                        {name: "Meteos", position: 'jungler', score: 20, value: 5000, points_per_game: 22.1}])
leagues = League.create([{name: "50/50 Bid Money", cost: 1, max_participants: 30, status: "Upcoming", start_time: DateTime.now },
                        {name: "50/50 Holla", cost: 90, max_participants: 50, status: "Upcoming", start_time: DateTime.now },
                        {name: "50/50 Bid Money", cost: 10, max_participants: 30, status: "Past", start_time: DateTime.now },
                        {name: "50/50 Cool Guys", cost: 5, max_participants: 250, status: "Past", start_time: DateTime.now },
                        {name: "50/50 Live Guys", cost: 3, max_participants: 12, status: "Live", start_time: DateTime.now },
                        {name: "50/50 Big Winners", cost: 100, max_participants: 1000, status: "Live", start_time: DateTime.now }])
