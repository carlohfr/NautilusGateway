import socket 
import time

HOST = input("Digite o ip do gateway: ")
PORT = 10000
ADDR = (HOST, PORT)
BUF_SIZE = 1024

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect(ADDR)

reg_message = f"version: 1.0\r\nto: {HOST}:{PORT}\r\nfrom: client\r\n"
reg_message += "action: register-client\r\ntype: request\r\nbody-size: 0\r\n\r\n"
reg_message = reg_message.encode("utf-8")
sock.send(reg_message)

return_message = sock.recv(BUF_SIZE)
return_message = return_message.decode("utf-8") 
return_message = return_message.split("\r\n\r\n")
this_id = return_message[1]
print(f"ID do Client: {this_id}")

while True:
    message = sock.recv(BUF_SIZE)
    message = message.decode("utf-8") 
    message = message.split("\r\n\r\n")
    remote_id = message[0].split("\r\n")
    remote_id = remote_id[2].split("from: ")
    remote_id = remote_id[1]

    print(f"\nMensagem recebida de: {remote_id}")

    pong_message = f"version: 1.0\r\nto: {remote_id}\r\nfrom: {this_id}\r\n"
    pong_message += f"action: send-to-client\r\ntype: text\r\nbody-size: 4\r\n\r\nPONG"
    pong_message = pong_message.encode("utf-8")
    sock.send(pong_message)

time.sleep(2)
sock.close()
