import socket 
import time

HOST = '127.0.0.1'
PORT = 10000
ADDR = (HOST, PORT)
BUF_SIZE = 1024

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect(ADDR)

reg_message = "version: 1.0\r\nto: 127.0.0.1:10000\r\nfrom: client\r\n"
reg_message += "action: register-client\r\ntype: request\r\nbody-size: 0\r\n\r\n"
reg_message = reg_message.encode("utf-8")
sock.send(reg_message)

return_message = sock.recv(BUF_SIZE)
return_message = return_message.decode("utf-8") 
return_message = return_message.split("\r\n\r\n")
this_id = return_message[1]
print(f"This id: {this_id}")

while True:
    return_message = sock.recv(BUF_SIZE)
    return_message = return_message.decode("utf-8") 
    return_message = return_message.split("\r\n\r\n")
    message = return_message[1]
    message_from = return_message[0].split("\r\n")
    message_from = message_from[2].split("from: ")
    message_from = message_from[1]    
    print(f"{message_from} diz: {message}")

time.sleep(2)
sock.close()
