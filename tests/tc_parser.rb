# frozen_string_literal: true

require_relative '../parser'
require_relative '../game'
require 'test/unit'

class TestParser < Test::Unit::TestCase

  def test_file_path_typecheck
    assert_raise(RuntimeError) { LogParser.new(1) }
  end

end
