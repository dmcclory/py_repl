
#

READ-EVAL-PRINT Loop

#

instant feedback is crucial for skill development
REPLs provide instant feedback
Therefore REPLs are crucial

#

```ruby
require 'readline'

while buf = Readline.readline("> ", true)
  if buf == "exit"
    break
  else
    p buf
  end
end
```

#

```
$ cd ~/.gem/ruby/2.0.0/gems/rb-readline-0.5.1/
$ wc -l lib/*
     18 lib/rb-readline.rb
   8866 lib/rbreadline.rb
    529 lib/readline.rb
   9413 total
```

#

```ruby
  # from rbreadline.rb
  @emacs_standard_keymap = {
      "\C-@" => :rl_set_mark  ,
      "\C-a" => :rl_beg_of_line  ,
      "\C-b" => :rl_backward_char  ,
      "\C-d" => :rl_delete  ,
      "\C-e" => :rl_end_of_line  ,
      "\C-f" => :rl_forward_char  ,
      ...
  }
```

#

features:

- history
- completion
- emacs and vim mode

Bash uses it.

#

hard part is done!

#

```ruby
while buf = Readline.readline(">>>", true)
  buf += "\n\n"
  if buf == "exit\n\n"
    break
  else
    begin
      puts py_cly.eval buf
      buf = ""
    # ...
```

#

```ruby
class PyCly
  def initialize
    @input, @output, @err, @proc =
    Open3::popen3 "python lib/interpreter.py"
  end
end
```

#

```ruby
class PyCly
  def eval string
    @input.puts string
    IO.select([@python_output])
    @output.read_nonblock(100000)
  end
end
```

#

```python
while True:
  try:
    text = read_chunks()
    tree = ast.parse(text)
    if isexpression(tree):
      print eval(text)
    else:
      exec(text)
      print ""
```

#

```ruby
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
```

#

Demo!

#

RIPL

customizable Ruby REPL

#

```ruby
  # Ripl's main loop:

  def loop
    before_loop
    in_loop
    after_loop
  end
```

#

```ruby
class Ripl::Shell
  def loop_once
    @error_raised = nil
    @input = get_input
    throw(:ripl_exit) if EXIT_WORDS.include?(@input)
    eval_input(@input)
    print_result(@result)
  rescue Interrupt
    handle_interrupt
  end
end
```

#

That's it!

REPLs rule! Go learn something!
