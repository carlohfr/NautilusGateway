import socket 

HOST = '127.0.0.1'
PORT = 10000
ADDR = (HOST, PORT)
BUF_SIZE = 1024

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect(ADDR)

data = "test"
data = data.encode("utf-8")
sock.send(data)

response = sock.recv(BUF_SIZE)
print(response.decode('utf-8'))

sock.close()
