package org.szi.lng.networking;

import java.io.*;
import java.net.*;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/24/2012
 * Time: 2:01 PM
 * To change this template use File | Settings | File Templates.
 */
public class WebClientDemo {

    static void printUrl(String urlstr) throws Exception {
        URL url = new URL(urlstr);
        URLConnection connection = url.openConnection();
        connection.connect();
        InputStream in = connection.getInputStream();
        try {
            byte[] buf = new byte[1024];
            int nread = 0;
            while ((nread = in.read(buf)) > 0) {
                System.out.write(buf, 0, nread);
            }
            System.out.flush();
        } finally {
            in.close();
        }

    }


    public static void main(String[] args) throws Exception {
           String urlStr = "http://www.cern.ch";
           printUrl(urlStr);
        }

}



