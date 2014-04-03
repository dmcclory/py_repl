
require 'readline'

while buf = Readline.readline("> ", true)
  if buf == "exit"
    break
  else
    p buf
  end
end
