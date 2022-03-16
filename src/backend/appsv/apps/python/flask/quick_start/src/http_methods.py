from flask import Flask

app = Flask(__name__)

from flask import request

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        return do_the_login()
    else:
        return show_the_login_form()

def do_the_login():
    return 'do_the_login'

def show_the_login_form():
    return 'show_the_login_form'
