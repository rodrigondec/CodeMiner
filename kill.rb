# frozen_string_literal: true

require_relative 'player'

# Class representing a kill. Contains the killer, victim and the mean
class Kill
  # Initialize a +Kill+ instance
  # Params:
  # *killer*:: +Player+ instance of the killer. May be nil
  # *victim*:: +Player+ instance of the victim
  # *mean*:: String with the cause of death
  def initialize(killer, victim, mean)
    raise('Killer must be a Player instance or nil') unless
      killer.is_a?(Player) || killer.nil?
    raise('Victim must be a Player instance') unless victim.is_a?(Player)
    raise('Mean must be a String') unless mean.is_a?(String)

    @killer = killer
    @victim = victim
    @mean = mean
  end

  attr_reader :mean, :killer, :victim
end
