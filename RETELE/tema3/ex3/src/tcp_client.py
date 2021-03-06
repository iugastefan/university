# TCP client
import socket
import logging
import time
import sys

logging.basicConfig(
    format=u'[LINE:%(lineno)d]# %(levelname)-8s [%(asctime)s]  %(message)s', level=logging.NOTSET)

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

port = 10000
adresa = '198.13.0.14'
server_address = (adresa, port)
mesaj = 'HELLO FROM CLIENT'

while True:
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        logging.info('Handshake cu %s', str(server_address))
        sock.connect(server_address)
        time.sleep(5)
        sock.send(mesaj)
        data = sock.recv(1024)
        logging.info('Content primit: "%s"', data)

    finally:
        logging.info('closing socket')
        sock.close()
