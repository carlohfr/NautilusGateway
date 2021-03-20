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

return_message = sock.recv(BUF_SIZE)
return_message = return_message.decode("utf-8") 
return_message = return_message.split("\r\n\r\n")
return_message = return_message[1]

time.sleep(1)

sendC = f"version: 1.0\r\nto: 0A9B9D242AD04880B732A08F520A457B@127.0.0.1:10000\r\nfrom: {return_message}\r\naction: send-to-client\r\ntype: type/filetype\r\nbody-size: 14\r\n\r\ncontent\r\n\r\nend"
sendC = sendC.encode("utf-8")
sock.send(sendC)

time.sleep(1)

sock.close()
