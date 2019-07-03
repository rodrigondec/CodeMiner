#!/usr/bin/ruby -w
# frozen_string_literal: true

require './game'
require 'pp'

# Class for parsing the games.log
class LogParser
  def initialize(file_path)
    file = File.open(file_path)
    @data = []
    file.each_line do |line|
      @data.push(line)
    end
    file.close
    @games = []
    parse
  end

  attr_reader :games

  def get_game(game_index)
    @games[game_index]
  end

  def get_game_info(game_index)
    game = get_game(game_index)
    game.info
  end

  def all_games_info
    info = []
    @games.each_index do |index|
      info.push(get_game_info(index))
    end
    info
  end

  private

  def parse
    game = nil
    game_number = 1
    @data.each do |line|
      if line.include?('InitGame:')
        game = Game.new("Game #{game_number}")
        game_number += 1
        @games.push(game)
      elsif line.include?('ClientUserinfoChanged:')
        game.process_user_info_line(line)
      elsif line.include?('Kill:')
        game.process_kill_line(line)
      end
    end
  end
end
