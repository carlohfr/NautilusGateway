import socket 
import time

HOST = '127.0.0.1'
PORT = 10000
ADDR = (HOST, PORT)
BUF_SIZE = 1024


file = open("nautilus-header.txt", 'r')
data = file.read()
file.close()

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect(ADDR)

data = data.encode("utf-8")
sock.send(data)

#response = sock.recv(BUF_SIZE)
#print(response.decode('utf-8'))

time.sleep(1)

sock.close()
