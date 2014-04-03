require 'readline'
require 'py_cly'


py_cly = PyCly.new

while buf = Readline.readline("> ", true)
  if buf == "exit"
    break
  else
    begin
      puts py_cly.eval buf
    rescue Exception => e
      puts e
    end
  end
end

at_exit { py_cly.kill }
