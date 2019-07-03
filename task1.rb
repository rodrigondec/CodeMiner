# frozen_string_literal: true

if $PROGRAM_NAME == __FILE__
  require './parser'
  parser = LogParser.new('games.log')
  pp parser.get_game_info(0)
end
