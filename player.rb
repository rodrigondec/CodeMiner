# frozen_string_literal: true

# Class representing a player. Contains the name and kill counter of the player
class Player
  # Initialize a Player instance
  # Params:
  # +name+:: name string for the player
  def initialize(name)
    raise('Name must be a String') unless name.is_a?(String)

    @name = name
    @kills = 0
  end

  attr_reader :name, :kills

  # Increment the player kills counter
  def increment_kill
    @kills += 1
  end

  # Decrement the player kills counter
  def decrement_kill
    @kills -= 1
  end

  # Increment the player kills counter by a provided number
  # Params:
  # number:: numeric value to be added on the player kills counter
  def add_kills(number)
    raise unless number.is_a?(Numeric)

    @kills += number
  end
end
