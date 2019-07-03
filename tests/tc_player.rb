# frozen_string_literal: true

require_relative '../player'
require 'test/unit'

class TestPlayer < Test::Unit::TestCase

  def setup
    @player = Player.new('test')
  end

  def test_creation
    player = Player.new('test')

    assert_instance_of(Player, player)
    assert_equal('test', player.name)
    assert_equal(0, player.kills)
  end

  def test_name_typecheck
    assert_raise(RuntimeError) { Player.new(1) }
  end

  def test_increment_kill
    assert_equal(0, @player.kills)
    @player.increment_kill
    assert_equal(1, @player.kills)
  end

  def test_decrement_kill
    assert_equal(0, @player.kills)
    @player.decrement_kill
    assert_equal(-1, @player.kills)
  end

  def test_add_kills
    assert_equal(0, @player.kills)
    @player.add_kills(5)
    assert_equal(5, @player.kills)
  end

  def test_add_kills_type_check
    assert_equal(0, @player.kills)
    assert_raise(RuntimeError) { @player.add_kills('5') }
  end

end
