import socket
import struct

PACKET_HEAD = struct.pack('BBBB', 131,107,0,5)
print("PACKET_HEAD:", PACKET_HEAD)

# print(len("hello"), 'B'*5)

HOST = 'localhost'    # The remote host
PORT = 9090              # The same port as used by the server
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect((HOST, PORT))
    s.sendall(PACKET_HEAD+b'Hello, this is a python client message.'.ljust(8, b'\0'))
    data = s.recv(1024)

print("====>", data)
# unpack('BBBBB',data)

# def encode(strs):
# 	for x in xrange(1,10):
# 		pass

try:
    while 1:
        pass
except KeyboardInterrupt:
    pass

