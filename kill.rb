# frozen_string_literal: true

# Class representing a kill. Contains the killer, victim and the mean
class Kill
  def initialize(killer, victim, mean)
    @killer = killer
    @victim = victim
    @mean = mean
  end

  attr_reader :mean
end
