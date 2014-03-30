require 'open3'

class PyCly

  def initialize
    @python_input, @python_output, @python_err, @wait_thr = Open3::popen3 "python lib/interpreter.py"
  end

  def eval string
    @python_input.puts string
    IO.select([@python_output])
    @python_output.read_nonblock(100000)
  end

  def kill
    Process.kill 'HUP', @wait_thr.pid
  end

  def pid
    @wait_thr.pid
  end

end
