package org.szi.lng.networking;

import java.net.*;
import java.util.*;


/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/24/2012
 * Time: 1:55 PM
 * To change this template use File | Settings | File Templates.
 */
public class NICSdemo {


    static void showNICS()  throws SocketException {
        for (Enumeration nis = NetworkInterface.getNetworkInterfaces();
             nis.hasMoreElements();) {
            NetworkInterface ni = (NetworkInterface) nis.nextElement();
            System.out.println(ni.getDisplayName());
            for (Enumeration ias = ni.getInetAddresses();
                 ias.hasMoreElements();) {
                InetAddress ia = (InetAddress) ias.nextElement();
                System.out.println("\t" + ia.getHostAddress());
            }
        }
    }

    static void printNslookup(String inetadr) throws UnknownHostException {
        InetAddress ia = InetAddress.getByName(inetadr);
        System.out.print(ia.getHostName());
        System.out.println(": " + ia.getHostAddress());
    }



    public static void main(String[] args) throws SocketException, UnknownHostException {
          showNICS();
          printNslookup("www.cern.ch");
    }

}
