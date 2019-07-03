# frozen_string_literal: true

require_relative '../kill'
require_relative '../player'
require_relative '../game'
require 'test/unit'

class TestGame < Test::Unit::TestCase

  def setup
    @user_info_line = '20:34 ClientUserinfoChanged: 2 n\Isgalamido\t\0\model\xian/default\hmodel\xian/default\g_redteam\\g_blueteam\\c1\4\c2\5\hc\100\w\0\l\0\tt\0\tl\0'
    @kill_line = '20:54 Kill: 1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT'

    @game = Game.new('Game 1')
  end

  def test_creation
    game = Game.new('Game 1')
    assert_instance_of(Game, game)
    assert_equal('Game 1', game.name)
    assert_equal({}, game.players)
    assert_equal([], game.kills)
  end

  def test_name_typecheck
    assert_raise(RuntimeError) { Game.new(1) }
  end
