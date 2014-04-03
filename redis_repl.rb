require 'socket'
require 'readline'

class RedisInterface
  def initialize
    @socket = TCPSocket.new 'localhost', 6379
  end

  def to_resp(command)
    terms = command.split(" ")
    length_marker = "*#{terms.length}\r\n"
    length_marker + terms.map { |term| ["$#{term.length}", term] }.flatten.join("\r\n") + "\r\n"
  end

  def eval(command)
    @socket.write to_resp(command)
    IO.select([@socket])
    # still need to convert these results from RASP
    # need to figure out a way to read bigger chunks:
    # not sure why, but read_nonblock works WAAAY better for this!
    #   - read blocks ... until the connection closes?
    @socket.read_nonblock(500)
  end

  def close
    @socket.close
  end
end

redis = RedisInterface.new

while buf = Readline.readline("> ", true)
  if buf == "exit"
    break
  else
    p redis.eval(buf)
  end
end

redis.close
