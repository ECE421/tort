require_relative 'helper'

class TortTest < Test::Unit::TestCase
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_initialization
    sorter = Tort.new
    assert_true(sorter.is_a?(Tort))
  end
end
