#!/usr/bin/ruby -w
# frozen_string_literal: true

require './game'

# Class for parsing the games.log
class LogParser
  # Initialize a LogParser instance and parse the file.log
  # Params:
  # +file_path+:: file location String
  def initialize(file_path)
    raise('File path must be a String') unless file_path.is_a?(String)

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

  # return a game given a index
  # Params:
  # +game_index+:: game index for the list
  def get_game(game_index)
    @games[game_index]
  end

  # return a game info given a index
  # Params:
  # +game_index+:: game index for the list
  def get_game_info(game_index)
    game = get_game(game_index)
    game.info
  end

  # return a games info list
  def all_games_info
    info = []
    @games.each_index do |index|
      info.push(get_game_info(index))
    end
    info
  end

  private

  # parse the file.log provided
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
