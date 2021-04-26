import socket 
import time

HOST = '127.0.0.1'
PORT = 10000
ADDR = (HOST, PORT)
BUF_SIZE = 1024

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect(ADDR)

reg_message = "version: 1.0\r\nto: 127.0.0.1:10000\r\nfrom: client\r\naction: register-client\r\ntype: request\r\nbody-size: 0\r\n\r\n"
reg_message = reg_message.encode("utf-8")
sock.send(reg_message)

return_message = sock.recv(BUF_SIZE)
return_message = return_message.decode("utf-8") 
return_message = return_message.split("\r\n\r\n")
this_id = return_message[1]

message = f"version: 1.0\r\nto: A7070950E4BE4EF29FA6553211FD2ABB@127.0.0.1:10000\r\nfrom: {this_id}\r\n"
message += "action: test-action\r\ntype: text\r\nbody-size: 9\r\n\r\nOla mundo"
message = message.encode("utf-8")
print(message)
sock.send(message)

time.sleep(2)

sock.close()
