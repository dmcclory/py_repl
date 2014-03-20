Ok... let's do this.

A python REPL, written in Ruby?

Readline
Python process
Socket connection on both sides
Python evals code, sends back result

or we can do rubyracer repl.
  - and maybe load underscore?


#### the tiniest REPL:

```
require 'readline'

while buf = Readline.readline("> ", true)
  if buf == "exit"
    break
  else
    p buf
  end
end
```
