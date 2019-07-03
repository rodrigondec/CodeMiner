# frozen_string_literal: true

if $PROGRAM_NAME == __FILE__
  require './parser'
  require 'pp'

  parser = LogParser.new('games.log')
  pp parser.get_game_info(0)
end
