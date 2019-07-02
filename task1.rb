# frozen_string_literal: true

if $PROGRAM_NAME == __FILE__
  require './parser'
  parser = LogParser.new('games.log')
  parser.info
end
