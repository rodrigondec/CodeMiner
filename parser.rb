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
  end

  def parse
    game = nil
    @data.each do |line|
      if line.include?('InitGame:')
        game = Game.new(line)
        @games.push(game)
      elsif line.include?('Kill:')
        game.process_kill_line(line)
      end
    end
  end
end