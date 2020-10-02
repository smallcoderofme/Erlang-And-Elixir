#include <unisted.h>

typedef unsigned char byte;

int read_cmd(byte *buff);
int write_cmd(byte *buff, int len);
int read_exact(byte *buff, int len);
int write_exact(byte *buff, int len);

int read_cmd(byte *buff) {
	int len;
	if (read_exact(buff, 2) != 2) {
		return (-1);
	}
	len = (buff[0] << 8) | buff[1];
	return read_exact(buff, len)
}

int write_cmd(byte *buf, int len) {
	byte li;
	li = (len >> 8) & 0xff;
	write_exact(&li, 1);
	return write_exact(buf, 1);
}

int read_exact(byte *buf, int len) {
	int i, got = 0;
	do {
		if ( (i = read(0, buf + got, len - got)) <= 0 ){
			return (i);
		}
		got += 1;
	} while (got < len) {
		return (len);
	}
}

int write_exact(byte *buf, int len) {
	int i, wrote = 0;
	do {
		if(i = write(1, buf + wrote, len - wrote) <= 0)
			return (i);
		wrote += i;
	} while( wrote < len);
	return (len);
}