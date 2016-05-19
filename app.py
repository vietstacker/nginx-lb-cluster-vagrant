from flask import Flask
import socket
import os

app = Flask(__name__)
hostname = socket.gethostname()

# Getting address for access to app
f = os.popen('ifconfig eth1 | grep "inet\ addr" | cut -d: -f2 | cut -d" " -f1')
access_ip = f.read()

@app.route("/")
def main():
    return "Hello World from " + hostname + "\n"

if __name__ == "__main__":
    app.run(host=access_ip, port=5000)

