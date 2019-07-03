# frozen_string_literal: true

require_relative '../parser'
require_relative '../game'
require 'test/unit'

class TestParser < Test::Unit::TestCase

  def test_file_path_typecheck
    assert_raise(RuntimeError) { LogParser.new(1) }
  end

  def test_invalid_file_path
    assert_raise(Errno::ENOENT) { LogParser.new('asdadsadasdasdasdsad.log') }
  end

  def test_game_1
    parser = LogParser.new("#{File.dirname(__FILE__)}/data/game_1.log")
    assert_equal(1, parser.games.length)
    game = parser.get_game(0)
    assert_instance_of(Game, game)
    assert_equal('Game 1', game.name)
    assert_equal(1, game.players.length)
    assert_equal(0, game.kills.length)
  end

  def test_game_2
    parser = LogParser.new("#{File.dirname(__FILE__)}/data/game_2.log")
    assert_equal(1, parser.games.length)
    game = parser.get_game(0)
    assert_instance_of(Game, game)
    assert_equal('Game 1', game.name)
    assert_equal(3, game.players.length)
    assert_equal(11, game.kills.length)
  end

  def test_games_1_2
    parser = LogParser.new("#{File.dirname(__FILE__)}/data/games_1-2.log")
    assert_equal(2, parser.games.length)

    game_1 = parser.get_game(0)
    assert_instance_of(Game, game_1)
    assert_equal('Game 1', game_1.name)
    assert_equal(1, game_1.players.length)
    assert_equal(0, game_1.kills.length)

    game_2 = parser.get_game(1)
    assert_instance_of(Game, game_2)
    assert_equal('Game 2', game_2.name)
    assert_equal(3, game_2.players.length)
    assert_equal(11, game_2.kills.length)
  end

end
