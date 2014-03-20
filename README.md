Ok... let's do this.

A python REPL, written in Ruby?
  - not possible :(

or we can do rubyracer repl.
  - and maybe load underscore?

language Hybrids
  - Python & Ruby
    - Pygments.rb
      - forks a child python process, communicates with shared IO pipe
  - Ruby & Javascript
    - therubyracer/V8
      - my repl used it.
      - ???
    - poltergeist
      - runs a server, communicates with Phantom.js over websockets

tried to do readline repl for python, but python's eval/exec statements are much harder to use than Javascript's.

talk ideas:

REPLs are awesome. Between the shell, IRB we spend countless hours working in them. They're also extremely easy to write, thanks to readline. In this talk we'll iterate on a few versions of a {javascript, coffeescript, clojurescript} repl in Ruby.

Reader
  - readline
Evaluator
  - context

readline: the ultimate cheap trick.
  - ctrl-a, ctrl-k, ctrl-y for free
  - history for free

evaluator
  - ruby binding to evaluate things within
    - btw, this is what IRB does

bonus features:
  - not just dying when you have an error.
  - numbers
  - syntax highlighting

mega round:
  - javascript repl
  - coffeescript


#### the tiniest RPL (read-print-loop):

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

# a minimal Javascript REPL

```
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
```
