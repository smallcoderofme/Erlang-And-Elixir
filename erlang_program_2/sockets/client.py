import socket
from struct import *

# ret = socket.getaddrinfo("localhost", 2345, proto=socket.IPPROTO_TCP)
# print(ret)
# # {packet,4} 的意思是每个应用程序消息前部都有一个4字节的长度包头
# # Echo client program

# HOST = 'localhost'    # The remote host
# PORT = 2345              # The same port as used by the server
# s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# # now connect to the web server on port 80 - the normal http port
# s.connect((HOST, PORT))
# # packet = pack('lccccc', 131, 's', 'h', 'u', 'a', 'i')

# s.sendall(b'hello')
# s.close()
def encode(str):
	ret = ''
	for char in str:
		ret +=ord(char)
		pass
	return ret
ret = encode("hello")
print(ret)



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