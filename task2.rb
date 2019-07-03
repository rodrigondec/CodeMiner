# frozen_string_literal: true

if $PROGRAM_NAME == __FILE__
  require './parser'

  parser = LogParser.new('games.log')

  # Getting all players from all games
  # The kills from player from each game has to be summed
  global_players_hash = {}
  parser.games.each do |game|
    game.players.each_value do |player|
      if global_players_hash.key?(player.name)
        global_players_hash[player.name].add_kills(player.kills)
      else
        global_players_hash[player.name] = player
      end
    end
  end

  # Parsing hash to list of hashs
  global_players_list = []
  global_players_hash.each_value do |player|
    global_players_list.push(name: player.name, kills: player.kills)
  end

  # Ordering list for global ranking
  global_ranking = global_players_list.sort_by { |info| -info[:kills] }

  # Printing game info e game ranking
  parser.games.each_index do |index|
    game = parser.games[index]
    game_index = "Game #{index + 1}"
    h = {}
    h[game_index] = game.info
    h[:ranking] = game.ranking
    pp h
  end

  # Printing global ranking
  h = {}
  h['ranking geral'] = global_ranking
  pp h
end
