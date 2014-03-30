require_relative './test_helper'

class PyClySimpleExpressions < Minitest::Test

  def setup
    @py_cly = PyCly.new
  end

  def test_that_py_cly_can_evaluate_simple_expressions
    assert_equal '4', @py_cly.eval('2 + 2').chomp
  end

  def test_that_py_cly_can_return_information_about_parse_errors
    result = @py_cly.eval('print 2 + ').chomp
    assert_equal 'invalid syntax', result
  end

  def test_that_py_cly_can_eval_multiple_expressions_in_same_space
    result = @py_cly.eval('print 2 + 2').chomp
    result2 = @py_cly.eval('print 2 + 2').chomp
    assert_equal result, result2
  end
end
