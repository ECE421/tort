require 'rlisp'
require 'test/unit'

class RLispTest < Test::Unit::TestCase
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_label
    l = RLisp.new
    l.eval [:label, :x, 15]
    assert_equal(15, l.eval(:x))
  end 
  
  def test_eq
    l = RLisp.new
    l.eval [:label, :x, 15]
    assert_equal(false, l.eval([:eq, 17, :x]))
    assert_equal(true, l.eval([:eq, 15, :x]))
  end 

  def test_quote
    l = RLisp.new
    assert_equal([7, 10, 12], l.eval([:quote, [7, 10, 12]]))
  end 

  def test_car
    l = RLisp.new
    assert_equal(7, l.eval([:car, [:quote, [7, 10, 12]]]))
  end

  def test_cdr
    l = RLisp.new
    assert_equal([10,12], l.eval([:cdr, [:quote, [7, 10, 12]]]))
  end
  
  def test_cons
    l = RLisp.new
    assert_equal([5, 7, 10, 12], l.eval([:cons, 5, [:quote, [7, 10, 12]]]))
  end

  def test_if
    l = RLisp.new
    assert_equal(7, l.eval([:if, [:eq, 5, 7], 6, 7]))
  end

  def test_atom
    l = RLisp.new
    assert_equal(false, l.eval([:atom, [:quote, [7, 10, 12]]]))
  end

  def test_lambda
    l = RLisp.new
    l.eval [:label, :second, [:quote, [:lambda, [:x], [:car, [:cdr, :x]]]]]
    assert_equal(10, l.eval([:second, [:quote, [7, 10, 12]]]))
  end
end
