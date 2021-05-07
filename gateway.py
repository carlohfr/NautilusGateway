import socket 
import time

HOST = '127.0.0.1'
PORT = 10000
ADDR = (HOST, PORT)
BUF_SIZE = 1024

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect(ADDR)

network_credentials = "network-name: rede1\r\nnetwork-password: 1q2w3e4r\r\ngateway-password: pass"

reg_message = f"version: 1.0\r\nto: 127.0.0.1:10000\r\nfrom: 127.0.0.1:50000\r\naction: register-gateway\r\ntype: request\r\nbody-size: {len(network_credentials)}\r\n\r\n{network_credentials}"
reg_message = reg_message.encode("utf-8")
sock.send(reg_message)

return_message = sock.recv(BUF_SIZE)
print(return_message)

time.sleep(2)

sock.close()
