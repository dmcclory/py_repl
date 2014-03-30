require 'open3'

class PyCly

  def initialize
    @python_input, @python_output, @python_err, @wait_thr = Open3::popen3 "python interpreter.py"
  end

  def eval string
    @python_input.puts string
    `python -c \"#{string}\"`
  end

  def kill
    Process.kill 'HUP', @wait_thr.pid
  end

end
