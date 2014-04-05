require 'readline'
require 'py_cly'

py_cly = PyCly.new

while buf = Readline.readline(">>>", true)
  buf += "\n\n"
  if buf == "exit\n\n"
    break
  else
    begin
      puts py_cly.eval buf
      buf = ""
    rescue PyCly::ParseError => e
      buf.chomp! if buf.match(/\n\n$/)
      while subbuf = Readline.readline("...", true)
        break if subbuf == ""
        buf += subbuf
        buf += "\n"
      end
      buf += "\n"
      retry
    end
  end
end

at_exit { py_cly.kill }
