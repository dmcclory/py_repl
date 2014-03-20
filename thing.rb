require 'readline'
require 'v8'

context = V8::Context.new

while buf = Readline.readline("> ", true)
  if buf == "exit"
    break
  else
    p context.eval buf
  end
end
