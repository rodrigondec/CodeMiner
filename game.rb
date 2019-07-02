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

  private

  def add_player(name)
    @players[name] = Player.new(name)
  end

  def add_kill(killer, victim, mean)
    @kills.push(Kill.new(killer, victim, mean))
  end
