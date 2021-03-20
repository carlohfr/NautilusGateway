import socket 
import time

HOST = '127.0.0.1'
PORT = 10000
ADDR = (HOST, PORT)
BUF_SIZE = 1024


sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect(ADDR)

reg = "version: 1.0\r\nto: x\r\nfrom: python script\r\naction: register-client\r\ntype: type/filetype\r\nbody-size: 14\r\n\r\ncontent\r\n\r\nend"
reg = reg.encode("utf-8")
sock.send(reg)


while True:
    print("\n")
    return_message = sock.recv(BUF_SIZE)
    print(return_message.decode('utf-8'))

sock.close()
