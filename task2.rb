# frozen_string_literal: true


if $PROGRAM_NAME == __FILE__
  require './parser'
  parser = LogParser.new('games.log')
  parser.games.each_index do |index|
    game = parser.games[index]
    game_index = "Game #{index + 1}"
    h = {}
    h[game_index] = game.info
    h[:ranking] = game.ranking
    pp h
  end
end
