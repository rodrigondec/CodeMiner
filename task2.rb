# frozen_string_literal: true

if $PROGRAM_NAME == __FILE__
  require './parser'
  parser = LogParser.new('games.log')
  players = {}
  parser.games.each do |game|
    game.players.each_value do |player|
      if players.key?(player.name)
        players[player.name].merge_kills(player.kills)
      else
        players[player.name] = player
      end
    end
  end

  players_list = []
  players.each_value do |player|
    players_list.push(name: player.name, kills: player.kills)
  end

  ranking_geral = players_list.sort_by { |info| -info[:kills] }

  parser.games.each_index do |index|
    game = parser.games[index]
    game_index = "Game #{index + 1}"
    h = {}
    h[game_index] = game.info
    h[:ranking] = game.ranking
    pp h
  end
  h = {}
  h['ranking geral'] = ranking_geral
  pp h
end
