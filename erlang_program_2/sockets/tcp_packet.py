import socket
import struct

class TCPPacket:
	"""docstring for ClassName"""
	def __init__(self, dport = 2345, sport = 65535, dst="lcoalhost", src="192.168.2.104", data="nothing"):
		self.dport = dport
		self.sport = sport
		self.src_ip = src
		self.dst_ip = dst
		self.data   = data
		self.raw = None
		self.create_tcp_feilds()

	def assemble_tcp_feilds(self):
		self.raw = struct.pack('!HHLLBBHHH',
			self.tcp_src,
			self.tcp_dst,
			self.tcp_seq,
			self.tap_ack,

			)
		pass