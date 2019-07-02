# frozen_string_literal: true

if $PROGRAM_NAME == __FILE__
  require './parser'
  parser = LogParser.new('games.log')
  parser.games.each_index do |index|
    game = parser.games[index]
    game_index = "Game #{index + 1}"

    kills_by_means = {}
    game.kills.each do |kill|
      if kills_by_means.key?(kill.mean)
        kills_by_means[kill.mean] += 1
      else
        kills_by_means[kill.mean] = 1
      end
    end

    kills_by_means = kills_by_means.sort_by { |mean, count| -count }
    kills_by_means.to_h
    h = {}
    h[game_index] = { 'kills_by_means': kills_by_means }
    pp h
  end
end
