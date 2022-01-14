import socket 
import time

HOST = input("Digite o ip do gateway para registro: ")
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



def get_client_list(gateway_ip, gateway_port):
    request_message = f"version: 1.0\r\nto: {HOST}:{PORT}\r\nfrom: client\r\n"
    request_message += "action: register-client\r\ntype: request\r\nbody-size: 0\r\n\r\n"
    request_message = request_message.encode("utf-8")

    sock.send(request_message)

    response_message = sock.recv(BUF_SIZE)
    response_message = response_message.decode("utf-8") 
    response_message = response_message.split("\r\n\r\n")
    response_message = return_message[1]


while True:
    pass

time.sleep(2)
sock.close()
