#!/usr/local/bin/python3

# Python implementation of rot13 client

import sys
from socket import *

if len(sys.argv) < 3:
  sys.stderr.write("usage: %s host service args ...\n" % sys.argv[0])
  raise SystemExit(1)

s = socket(AF_INET, SOCK_STREAM)
port = getservbyname(sys.argv[2]) #parses /etc/services
s.connect((sys.argv[1], port))

for message in sys.argv[3:] :
  s.send(message.encode('ascii'))   #ascii UTF-8 also works
  response = s.recv(len(message))
  print(response.decode(), end=" ")

s.close()
print()

