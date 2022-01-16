import socket 
import time


HOST = input("Digite o ip do gateway para registro: ")
PORT = 10000
ADDR = (HOST, PORT)
BUF_SIZE = 1024


clients_ids = []
gateways_ips = []


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


def add_clients_to_list(remote_clients):
    for remote_client in remote_clients:
        if remote_client not in clients_ids:
            clients_ids.append(remote_client)


def add_gateways_to_list(remote_gateways):
    for remote_gateway in remote_gateways:
        if remote_gateway not in gateways_ips:
            gateways_ips.append(remote_gateway)


def get_gateway_list(filename):
    gateway_list = []

    arq = open(filename)
    linhas = arq.readlines()

    for linha in linhas:
        linha = linha.replace("\n", "")
        gateway_list.append(linha)

    return gateway_list


def get_client_list(gateway_ip, gateway_port):
    network_credentials = "network-name: rede1\r\nnetwork-password: 1q2w3e4r\r\n"
    network_credentials += "gateway-password: pass\r\ncommand: get-client-list"
    request_message = f"version: 1.0\r\nto: {gateway_ip}:{gateway_port}\r\nfrom: {this_id}\r\n"
    request_message += f"action: send-to-gateway\r\ntype: command\r\n"
    request_message += f"body-size: {len(network_credentials)}\r\n\r\n{network_credentials}"
    
    request_message = request_message.encode("utf-8")
    sock.send(request_message)

    response_message = sock.recv(BUF_SIZE)
    response_message = response_message.decode("utf-8") 
    response_message = response_message.split("\r\n\r\n")
    response_message = response_message[1].split("\r\n")
    response_message = response_message[4].split(": ")
    response_message = response_message[1].replace("[", "")
    response_message = response_message.replace("]", "")
    response_message = response_message.split(", ")

    if this_id in response_message:
        response_message.remove(this_id)

    return response_message


def send_message_to_client(client_id):
    message = f"version: 1.0\r\nto: {client_id}\r\nfrom: {this_id}\r\n"
    message += f"action: send-to-client\r\ntype: text\r\n"
    message += f"body-size: 4\r\n\r\nPING"

    message = message.encode("utf-8")
    sock.send(message)

    start_time = time.time()
    print(f"\nMensagem enviada para: {client_id}")

    while True:
        response_message = sock.recv(BUF_SIZE)
        response_message = response_message.decode("utf-8") 
        response_message = response_message.split("\r\n\r\n")
        response_message = response_message[0].split("\r\n")
        response_message = response_message[2].split("from: ")
        remote_id = response_message[1]

        if remote_id == client_id:
            print(f"Mensagem recebida de: {remote_id}")

            response_time = time.time() - start_time
            print(f"Tempo de resposta: {response_time} segundos\n")
            break


# Obtendo a lista de gateways
add_gateways_to_list(get_gateway_list("gatewayips.txt"))

# Obtendo a lista de clients para cada gateway
for gateway_ip in gateways_ips:
    add_clients_to_list(get_client_list(gateway_ip, 10000))

# Enviando a mensagem para cada client da lista de clients
for client_id in clients_ids:
    send_message_to_client(client_id)


time.sleep(2)
sock.close()
