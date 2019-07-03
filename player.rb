# frozen_string_literal: true

# Class representing a player. Contains the name and kill counter of the player
class Player
  def initialize(name)
    raise('Name must be a String') unless name.is_a?(String)

    @name = name
    @kills = 0
  end

  attr_reader :name, :kills

  def increment_kill
    @kills += 1
  end

  def decrement_kill
    @kills -= 1
  end

  def add_kills(number)
    raise unless number.is_a?(Numeric)

    @kills += number
  end
end
