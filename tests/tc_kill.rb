# frozen_string_literal: true

require_relative '../kill'
require_relative '../player'
require 'test/unit'

class TestKill < Test::Unit::TestCase

  def test_creation
    killer = Player.new('killer')
    victim = Player.new('victim')
    kill = Kill.new(killer, victim, 'test')
    assert_instance_of(Kill, kill)
    assert_equal('test', kill.mean)
    assert_equal(killer, kill.killer)
    assert_equal(victim, kill.victim)
  end


end
