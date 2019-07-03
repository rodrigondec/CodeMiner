# frozen_string_literal: true

require './player'
require './kill'

# Class representing a game. Contains the name of the game,
# list of players and list of kills
class Game
  # Initialize a Game instance
  # Params:
  # +name+:: name string for the game
  def initialize(name)
    raise('Name must be a String') unless name.is_a?(String)

    @name = name
    @players = {}
    @kills = []
  end

  attr_reader :players, :kills, :name

  # returns a hash with information's about the game
  def info
    h = {}
    h[@name] = {
      total_kills: @kills.length,
      players: players_info,
      kills: kills_info
    }
    h
  end

  # returns a list with the ranking of the game
  def ranking
    kills_info.sort_by { |info| -info[:kills] }
  end

  # Process a kill line from the log
  def process_kill_line(kill_line)
    line_array = kill_line.split

    killed_index = line_array.index('killed')
    by_index = line_array.index('by')

    killer_name = line_array[killed_index - 1]
    victim_name = line_array[killed_index + 1]
    mean = line_array[by_index + 1]

    process_kill(killer_name, victim_name, mean)
  end

  # Process a user info line from the log
  def process_user_info_line(user_info_line)
    start_name_index = user_info_line.index('\\') + 1

    end_name_index = user_info_line[start_name_index..-1].index('\\') +
                     start_name_index - 1

    name = user_info_line[start_name_index..end_name_index]
    create_or_get_player(name)
  end

  private

  # returns a list with information's about the game players
  def players_info
    info = []
    @players.each_value do |player|
      info.push(player.name)
    end
    info
  end

  # returns a list with information's about the game players kills
  def kills_info
    info = []
    @players.each_value do |player|
      info.push(name: player.name, kills: player.kills)
    end
    info
  end

  # add a new +Player+ to the game
  def add_player(name)
    @players[name] = Player.new(name)
  end

  # add a new +Kill+ to the game
  def add_kill(killer, victim, mean)
    @kills.push(Kill.new(killer, victim, mean))
  end

  # create a new +Player+ to the game or get it's instance
  def create_or_get_player(name)
    add_player(name) unless @players.key?(name)
    @players[name]
  end

  # get the +Player+ instance or nil if the name is '<world>'
  def get_player(name)
    if name == '<world>'
      nil
    else
      create_or_get_player(name)
    end
  end

  # Process a kill with infos extracted from +process_kill_line+
  def process_kill(killer_name, victim_name, mean)
    killer = get_player(killer_name)
    victim = get_player(victim_name)

    if killer && killer != victim
      killer.increment_kill
    else
      victim.decrement_kill
    end

    add_kill(killer, victim, mean)
  end
end
