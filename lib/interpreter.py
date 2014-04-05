import sys
import ast

def isexpression(tree):
  return isinstance(tree.body[0], ast.Expr)

def read_chunks():
  buf = ""
  line = raw_input()
  while line != "":
    buf += line
    line = raw_input()
  return buf

while True:
  try:
    text = read_chunks()
    tree = ast.parse(text)
    if isexpression(tree):
      print eval(text)
    else:
      exec(text)
      print ""
    sys.stdout.flush()
  except SyntaxError, ex:
    print ex.msg
    print 'invalid syntax'
    sys.stdout.flush()
  except Exception, ex:
    print ex
    sys.stdout.flush()
