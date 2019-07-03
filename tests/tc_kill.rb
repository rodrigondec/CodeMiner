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

  def test_killer_nil
    killer = nil
    victim = Player.new('victim')
    kill = Kill.new(killer, victim, 'test')
    assert_instance_of(Kill, kill)
  end

  def test_killer_typecheck
    killer = 'killer'
    victim = Player.new('victim')
    assert_raise(RuntimeError) { Kill.new(killer, victim, 'test') }
  end

  def test_victim_typecheck
    killer = nil
    victim = 'victim'
    assert_raise(RuntimeError) { Kill.new(killer, victim, 'test') }
  end

  def test_mean_typecheck
    killer = Player.new('killer')
    victim = Player.new('victim')
    assert_raise(RuntimeError) { Kill.new(killer, victim, 1) }
  end

end
