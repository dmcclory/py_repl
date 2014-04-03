gem 'minitest'
require 'minitest/autorun'

$LOAD_PATH.unshift "lib"
require 'py_cly'

FIXTURES = {

  :square_function => "def square(x):\n  return x * x\n\n"

}
