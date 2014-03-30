Ok... let's do this.

A python REPL, written in Ruby?
  - not possible :(

actually, wait, this seems totally possible!

I found this article: (on using compile to get little executable objects)

so after playing with it for a little while, I realized we could give it multiple expressions, or multiple statements, or a combination.

it was a little funny, because it doesn't print the result unless you explictly say print. python's repl generally doesn't give any output for statements. it does give output for expression (either `5 * 5` or variable lookup).

so we could either 1) just punt, and say you have a repl where you have to ... use print to get results. or 2) we could use the parser/ast modules to parse a piece of code, check to see if it's an expression or a series of statements, and then either print nothing for statements or capture the result of the last expression (if it's an expression or series of expressions). that last bit sounds like fun.

that'll all be a little bit of python. and it will essentially be a repl. it'll be something that blocks for input, does some stuff when it gets input (on stdin? or a port?) and then returns output. maybe a port/server thing makes sense.

and then the ruby code will just be something to kick off the python server, and a readline loop which hangs out, submits code and presents the results.



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

I conducted an informal poll of programmers, I thought I'd share the results:

"In your professional opinion, repls are: "
 - A) the best thing in the universe.
 - B) an essential tool
 - C) meh

9/10 devs answered B.

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

So.. since they're so easy to write, and they're such an effective tool for learning about an engaging with a piece of software, if you're writing any kind of developer-facing software, just go ahead an put a REPL on it. Thanks.


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
