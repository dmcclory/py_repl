gem 'minitest'
require 'minitest/autorun'

$LOAD_PATH.unshift "lib"
require 'py_cly'

FIXTURES = {

  :square_function => "def square(x):\n  return x * x\n\n",

  :cool_class => "class Foo():\n  def __init__(self, x, y):\n    self.x = x\n    self.y = y\n  def sum(self):\n    return self.x + self.y\n\n",
  :cool_class =>
"""class Cool():
  def __init__(self, x, y):
    self.x = x
    self.y = y
  def sum(self):
    return self.x + self.y

"""

}
