require_relative './test_helper'

class PyClySimpleExpressions < Minitest::Test

  def setup
    @py_cly = PyCly.new
  end

  def test_that_py_cly_can_evaluate_simple_expressions
    assert_equal '4', @py_cly.eval("2 + 2\n\n").chomp
  end

  def test_that_py_cly_can_return_information_about_parse_errors
    assert_raises(PyCly::ParseError) {
      @py_cly.eval("print 2 + \n\n")
    }
  end

  def test_that_py_cly_can_eval_multiple_expressions_in_same_space
    result = @py_cly.eval("print 2 + 2\n\n").chomp
    result2 = @py_cly.eval("print 2 + 2\n\n").chomp
    assert_equal result, result2
  end

  def test_that_py_cly_can_execute_statements
    statement_output = @py_cly.eval("a = 2\n\n").chomp
    assert_equal "", statement_output
    variable_lookup = @py_cly.eval("a\n\n").chomp
    assert_equal "2", variable_lookup
  end

  def test_that_py_cly_can_define_functions
    statement_output = @py_cly.eval(FIXTURES[:square_function]).chomp
    result = @py_cly.eval("square(10)\n\n").chomp
    assert_equal "100", result
  end
end
