import socket
from struct import *

# ret = socket.getaddrinfo("localhost", 2345, proto=socket.IPPROTO_TCP)
# print(ret)
# # {packet,4} 的意思是每个应用程序消息前部都有一个4字节的长度包头
# # Echo client program
# def encodeErl(strs):
#     ret = '131,107,0,5'
#     for char in strs:
#         ret = ret + ","
#         ret =ret + str(ord(char))
#         pass
#     ret = ret + ""
#     return ret
vaa = pack('BBBBBBBBB', 131,107,0,5,104,101,108,108,111)
print(vaa)

# print(len("hello"), 'B'*5)

HOST = 'localhost'    # The remote host
PORT = 2345              # The same port as used by the server
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect((HOST, PORT))
    s.sendall(vaa)
    data = s.recv(1024)

print(unpack('BBBBBBBBB',data))




# # MSGLEN = 64

# def send_data(msg):
# 	totalsent = 0
# 	while totalsent < MSGLEN:
# 		sent = socket.send(msg[totalsent:])
# 		if sent == 0:
# 			raise RuntimeError("Socket nonnection broken.")
# 		totalsent = totalsent + sent
# 	pass


# import socket

# s=socket.socket(socket.F_PACKET, socket.SOCK_RAW, socket.ntohs(0x0800))

# while True:
# 	data=s.recvfrom(65565)
# 	try:
# 		if "HTTP" in data[0][54:]:
# 			print ("[","="*30,']')
# 			raw=data[0][54:]
# 			if "\r\n\r\n" in raw:
# 				line=raw.split('\r\n\r\n')[0]
# 				print("[*] Header Captured ")
# 				print(line[line.find('HTTP'):])
# 			else:
# 				print(raw)
# 		else:
# 			#print '[{}]'.format(data)
# 			pass
# 	except:
# 		pass