from flask import Flask
from flask import request

import ast

app = Flask(__name__)

@app.route('/')
def hello_world():
  return 'Hello World!'

@app.route('/cool')
def awesome():
  return 'skld'

@app.route('/echo', methods=['POST'])
def movingon():
  return request.form['code']

@app.route('/parse', methods=['POST'])
def try_parse():
  try:
    tree = ast.parse(request.form['code'])
    return 'PARSED!'
  except SyntaxError, ex:
    return 'FAILED TO PARSE!'

@app.route('/eval', methods=['POST'])
def try_eval():
  try:
    result = eval(request.form['code'])
    return str(result)
  except Exception, ex:
    return ex

@app.route('/exec', methods=['POST'])
def try_exec():
  try:
    exec(request.form['code'])
    return "EXEC'D"
  except Exception, ex:
    return ex


if __name__ == '__main__':
  app.run()
