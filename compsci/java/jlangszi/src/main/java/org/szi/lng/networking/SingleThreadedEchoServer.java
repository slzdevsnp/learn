package org.szi.lng.networking;

import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;
import java.net.Socket;
import java.net.ServerSocket;



public class SingleThreadedEchoServer   {

    static void runEchoServer()throws IOException{
        int port = 8081;
        ServerSocket serverSocket = new ServerSocket(port);  // open socket
        System.out.println("Listening on port " + port);
        System.out.println("(Control-C to terminate)");
        while(true) {
            Socket clientSocket = serverSocket.accept(); // blocks
            try {
                InputStream in = clientSocket.getInputStream();
                OutputStream out = clientSocket.getOutputStream();
                int b;
                while ((b = in.read()) != -1) {
                    out.write(b);
                }
                out.flush();
            } finally {
                clientSocket.close();
            }

      }
    }

    public static void main(String[] args) throws IOException {
        //after java is launched  telnet localhost 8081  and type some chars
        runEchoServer();

    }


}
