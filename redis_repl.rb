require 'socket'
require 'readline'

@s = TCPSocket.new 'localhost', 6379

def to_resp(command)
  terms = command.split(" ")
  length_marker = "*#{terms.length}\r\n"
  length_marker + terms.map { |term| ["$#{term.length}", term] }.flatten.join("\r\n") + "\r\n"
end

def eval(command)
  @s.write to_resp(command)
  IO.select([@s])
  # still need to convert these results from RASP
  # need to figure out a way to read bigger chunks:
  # not sure why, but read_nonblock works WAAAY better for this!
  #   - read blocks ... until the connection closes?
  @s.read_nonblock(500)
end

while buf = Readline.readline("> ", true)
  if buf == "exit"
    break
  else
    p eval(buf)
  end
end

@s.close
