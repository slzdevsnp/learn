
Linux network programming course

chris brown

Contents
==========================
chap Setting the scene
chap writing tcp-based servers
chap writing tcp-based clients
chap writing udp-based server and clients
chap concurrent servers and clients
chap multi-threaded concurrency
==========================



chap Setting the scene
==========================
assume knowing of c
assume knowing of python
assume some knowledge of system programming 

tcp - connection-oriented service
udp - connectionless service

books:
    the linux programming interface (chpas 56 - 61)
    unix network programming (99% relevant to linux)

these technologies are not new (20 years)

socket: endpoint ip + port

http packet passed to:
tcp layer, ip layer, ethernet layer
-> ethernet package transmitted over network. 

server provides a service
clent sends request to server, obtains response

connectionless
udp protocol -  each message is individually addressed (like traditional postal service)
 - each message has a destination address
 - no delivery guarantee
 - messages can arrive in a different order that they were sent 
 - message boundaries are preserved: sent 3 msgs, 3 msgs to receive

connection-oriented
tcp protocoal  (like telephone communication,illusion of a copper wire between)
    - client needs an address of a server, server does not need to know the address of a client 
    - guaranteed delivery 
    - message boundaries are not preserved
endpoint = server's ip adrsse + portnumber
2 endpoints define a client - server connection 

C  = system's programming language

tools: lsof, nmap, wireshark
> sudo lsof -i TCP  # curent open tcp connections 
ports < 1024 can only by owned by processes running as root

>nmap -pN 192.168.0.10 #scan  remote ip for open port

wireshark (gui packet analyzer tool)
    click interface to capture
    click on word Capture 
    select interface to capture  eg en,  then define filter
    host 35.246.101.77 and port 22


chap 02 writing tcp-based servers
==========================

server: create a socket, bind port number, listen (establishes a queue) accept
client: create a socket connect , write request

ex: 02/rot13d.c
sock = socket(AF_INET, SOCK_STREAM, 0);
#SOCK_STREAM is for tcp

demo:
cd /home/sz_metafused_com/cpp/netprog/02
gcc -o ../bin/rot13 rot13d.c
../bin/rot13
sz_metafused_com@inst1-ldn:~$ lsof -i TCP
rot13   375 sz_metafused_com    3u  IPv4 144283      0t0  TCP *:1067 (LISTEN)

on the same machine
telnet localhost 1067
hello CR
Ctr-j  #to interrupt telnet connection

use the pythnn server
>rot13d.py

chap 03 writing tcp-based clients
==========================
I have enabled on gcp vm  1067-1068 tcp ports
demo:
cd /Users/zimine/GoogleDriveSlzdev/zrepos/slzdevsnp/learn/compsci/unix/linux_netprog/ref/0
>gcc -o ../bin/rot13client2 rot13client2.c
>../bin/rot13client2 35.246.101.77 1067|1068 hello
>../bin/rot13client2 35.246.101.77 instl_boots hello

---------------------------------
check /etc/services  for names for 1067,1068 ports
on osx instl_boots, instl_bootc
----------------------------------
./rot13client3.py  35.246.101.77 instl_bootc hello


chap 04 writing udp-based server and clients
==========================
    udp servers can broadcast
    udp is unreliable (packets may be dropped)

04/update1.c  #udp server
sendto()  #sending a datagram 
rcat.c ## client
recvfrom() #receiving a datagram

tftp (simplified ftp protocol)
port 69
    
demo:
on inst1-ldn
cd 04
sudo apt-get install xinetd tftpd
sudo mkdir /tftpboot
sudo chmod 777 /tftpboot
sudo chown nobody /tftpboot
sudo cp tftp  /etc/xinetd.d/
sudo /etc/init.d/xinetd restart
sudo lsof -i  | grep tftp
cp /etc/services /tftpboot
gcc -o ../bin/rcat rcat.c
../bin/rcat localhost services  #rcat working

broadcasting
launch update1  on 
serveral machines, 

sudo apt-get install libncurses5-dev
gcc -o  ../bin/update1 update1.c  -lncurses

../bin/update1 flora
  ### launch it on several machines


gcc -o  ../bin/update2 update2.c  -lncurses
../bin/update2 fauna


chap 05 concurrent servers and clients
==========================
focus on server side
if (fork()==0)  #forking a request

demo:
hangman_concurrent.c server

gcc -o ../bin/hangman hangman_concurrent.c

in other 2 terminals:
telnet localhost 1068
telnet localhost 1068

zombie processes

concurrency within a single process
using select()
multiple incrementing file descriptors

numguess1.c  #relatively simple

 gcc -o ../bin/numguess numguess1.c
 ../bin/numguess

 in terminals
 telnet localhost 1500

chap 06 multi-threaded concurrency
==========================
threads a different from processes
process is a container for resources . has a heap, a data segment, an environment, file descriptors, stdin, stdout

thread:
has a stack, cpu registers,
a state, a priority

threads share code, global, static vars, open file descriptors

threads to not share local to funcs variables.  

posix   pthreads
pthread_create(.., myfunc,...) 
phtread_exit()
or pthread_cancel()
or pthread_join()

thread_demo.c

no_mutex_demo.c #bad example

mutex_demo.c
race conditions are happening unpredictably, difficult to test

gcc -o ../bin/no_mutex_demo no_mutex_demo.c -lpthread

gcc -o ../bin/mutex_demo mutex_demo.c -lpthread

no_mutex_demo : unpredictable results

mutex_demo : predictable results

processor farm
primes example
primes_server.c is non-concurrent
primes_client.c is concurrent (connect to multiple servers)

examine code

on server
gcc -o ../bin/prime_server prime_server.c 

launch prime_server on localhost and on remote machine (simulate 2 servers)
bin/prime_server  (listents on p 1070)

on clients
gcc -o ../bin/prime_client prime_client.c

launch client
bin/prime_client -n 1000000 -c 100000 35.246.101.77 localhost

see the distributed computing:
time ../bin/prime_client  -n 10000000 -c 100000 localhost   
#8.6 sec

time ../bin/prime_client  -n 10000000 -c 100000 localhost 35.246.101.77
#4.3 sec





