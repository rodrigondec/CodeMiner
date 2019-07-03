# frozen_string_literal: true

require_relative 'tests/tc_player'
require_relative 'tests/tc_kill'
require_relative 'tests/tc_game'
require 'test/unit'
require 'test/unit/ui/console/testrunner'

# create a new empty TestSuite, giving it a name
test_suite = Test::Unit::TestSuite.new('My custom test suite')
test_suite << TestPlayer.suite
test_suite << TestKill.suite
test_suite << TestGame.suite

# run the suite
Test::Unit::UI::Console::TestRunner.run(test_suite)
