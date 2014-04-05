require_relative './test_helper'
require 'faraday'

CONN = Faraday.new(url: 'http://localhost:5000')

class PyClyServerTests < Minitest::Test

  def setup
    @server = IO.popen('python lib/server.py')
    @client = CONN
    sleep 1
  end

  def teardown
    Process.kill "HUP", @server.pid
  end

  def test_that_we_can_send_code_to_the_server
    example = "def foo(x):\n  return x * x\n\n"
    d = @client.post '/echo', { :code => example }
    assert_equal d.body, example
  end

  def test_that_we_can_get_successful_parse_notifications
    example = "def foo(x):\n  return x * x\n\n"
    d = @client.post '/parse', { :code => example }
    assert_equal d.body, 'PARSED!'
  end

  def test_that_we_can_get_parse_error_notifications
    example = "def foo(x):\n  return x x\n\n"
    d = @client.post '/parse', { :code => example }
    assert_equal d.body, 'FAILED TO PARSE!'
  end

  def test_that_we_can_eval_code
    example = "def foo(x):\n  return x * x\n\n"
    @client.post '/exec', { :code => example }
    execute = "foo(100)"
    d = @client.post '/eval', { :code => execute }
    require 'pry'; binding.pry
    assert_equal d.body, '10000'

  end

end
