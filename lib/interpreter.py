import sys

while True:
  try:
    text = raw_input()
    print eval(text)
    sys.stdout.flush()
  except SyntaxError, ex:
    print ex.msg
    sys.stdout.flush()
