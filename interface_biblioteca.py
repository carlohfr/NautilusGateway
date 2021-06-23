
# EXEMPLOS

from _thread import *
import threading 
import socket
import sys
import os

# Necessario refinar o codigo para tratar os erros 

class Tunnel:

    BUF_SIZE = 1024 # Tamanho do buffer

    def __init__(self, REMOTE_HOST, REMOTE_PORT, LOCAL_HOST, LOCAL_PORT):
        super().__init__()

        self.REMOTE_HOST = REMOTE_HOST
        self.REMOTE_PORT = REMOTE_PORT
        self.LOCAL_HOST = LOCAL_HOST
        self.LOCAL_PORT = LOCAL_PORT

    def create_connection(self):
        # Client socket to remote supernode
        self.remoteTCP = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.remoteTCP.connect((self.REMOTE_HOST, self.REMOTE_PORT))

        # Server socket to local client
        self.localTCP = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
        self.localTCP.bind((self.LOCAL_HOST, self.LOCAL_PORT))
        self.localTCP.listen(8)

    # Receive data from remote server and send to local client 
    def client_recv(self, local_sock):
        while True:
            msg = self.remoteTCP.recv(self.BUF_SIZE)
            local_sock.send(msg)

    # Receive data from local client and send to remote server
    def client_send(self, local_sock):
        while True:
            msg = local_sock.recv(self.BUF_SIZE)
            self.remoteTCP.send(msg)

    # Accept local socket connections
    def run(self):
        self.create_connection()
        while True:
            con, client = self.localTCP.accept()
            start_new_thread(self.client_recv, (con, ))
            start_new_thread(self.client_send, (con, ))


conection = Tunnel("127.0.0.1", 9999, "127.0.0.1", 5000)
conection.run()





############################################################################


class NautilusClient():

    def __init__(self):
        pass


    # thread
    def receive_message(self):
        # deve validar a mensagem recebida e passar para uma função com o nome de "handle message", que deve ser determinada pelo client adapter
        self.handle_message("data")


    def send_message(self, message):
        # deve validar a mensagem e enviar para o gateway
        pass


    def connect(self, host):
        # deve criar o socket e tornar ele global 
        # se registrar no gateway e salvar os dados de conexão de forma global nessa classe
        # iniciar a thread que ira receber as mensagens do gateway
        self.__host = host

    
    def disconnect(self):
        # deve fechar o socket e limpar os dados salvos nessa classe
        pass


    def get_current_id(self):
        return "id"



    

   


##############################################################


class NautilusClientAdapter(NautilusClient):

    def __init__(self, host):
        super().__init__()
        self.connect(host)
        print(self.get_current_id())

    def send_msg(self, to, msg):
        self.send_message(to, msg)

    def handle_message(self, data):
        pass
