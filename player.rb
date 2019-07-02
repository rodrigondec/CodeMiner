# frozen_string_literal: true

# Class representing a player. Contains the name and kill counter of the player
class Player
  def initialize(name)
    @name = name
    @kills = 0
  end

  attr_reader :name
  attr_reader :kills

  def increment_kill
    @kills += 1
  end

  def decrement_kill
    @kills -= 1
  end

  def add_kills(number)
    @kills += number
  end
end
