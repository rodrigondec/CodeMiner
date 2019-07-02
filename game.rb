# frozen_string_literal: true

require './player'
require './kill'
require 'pp'

# Class representing a game. Contains the name of the game,
# list of players and list of kills
class Game
  def initialize(name)
    @name = name
    @players = {}
    @kills = []
  end

  attr_reader :players
  attr_reader :kills

  def info
    {
      total_kills: @kills.length,
      players: players_info,
      kills: kills_info
    }
  end

  def ranking
    kills_info.sort_by { |info| -info[:kills] }
  end

  def process_kill_line(kill_line)
    line_array = kill_line.split

    killed_index = line_array.index('killed')
    by_index = line_array.index('by')

    killer_name = line_array[killed_index - 1]
    victim_name = line_array[killed_index + 1]
    mean = line_array[by_index + 1]

    process_kill(killer_name, victim_name, mean)
  end

  def process_user_info_line(user_info_line)
    start_name_index = user_info_line.index('\\') + 1

    end_name_index = user_info_line[start_name_index..-1].index('\\') +
                     start_name_index - 1

    name = user_info_line[start_name_index..end_name_index]
    create_or_get_player(name)
  end

  private

  def players_info
    info = []
    @players.each_value do |player|
      info.push(player.name)
    end
    info
  end

  def kills_info
    info = []
    @players.each_value do |player|
      info.push(name: player.name, kills: player.kills)
    end
    info
  end

  def add_player(name)
    @players[name] = Player.new(name)
  end

  def add_kill(killer, victim, mean)
    @kills.push(Kill.new(killer, victim, mean))
  end

  def create_or_get_player(name)
    add_player(name) unless @players.key?(name)
    @players[name]
  end

  def get_player(name)
    if name == '<world>'
      nil
    else
      create_or_get_player(name)
    end
  end

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
