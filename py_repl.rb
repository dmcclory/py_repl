require 'readline'
require 'py_cly'

py_cly = PyCly.new

while buf = Readline.readline("> ", true)
  buf += "\n\n"
  if buf == "exit\n\n"
    break
  else
    begin
      puts py_cly.eval buf
      buf = ""
    rescue PyCly::ParseError => e
      buf.chomp! if buf.match(/\n\n$/)
      buf += Readline.readline("..", true)
      buf += "\n\n"
      puts e
      retry
    end
  end
end

at_exit { py_cly.kill }
