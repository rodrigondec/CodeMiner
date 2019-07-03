# frozen_string_literal: true

if $PROGRAM_NAME == __FILE__
  require './parser'
  parser = LogParser.new('games.log')

  parser.games.each do |game|

    # Creating hash counter entry for each mean of kill from the game
    kills_by_means = {}
    game.kills.each do |kill|
      if kills_by_means.key?(kill.mean)
        kills_by_means[kill.mean] += 1
      else
        kills_by_means[kill.mean] = 1
      end
    end

    # Ordering the hash for ranking like output
    kills_by_means = kills_by_means.sort_by { |mean, count| -count }
    kills_by_means.to_h
    h = {}
    h[game.name] = { 'kills_by_means': kills_by_means }
    pp h
  end
end
