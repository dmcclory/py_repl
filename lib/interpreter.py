import sys
import ast

def isexpression(tree):
  return isinstance(tree.body[0], ast.Expr)

while True:
  try:
    text = raw_input()
    tree = ast.parse(text)
    if isexpression(tree):
      print eval(text)
    else:
      exec(text)
      print ""
    sys.stdout.flush()
  except SyntaxError, ex:
    print ex.msg
    sys.stdout.flush()
  except Exception, ex:
    print ex
    sys.stdout.flush()
