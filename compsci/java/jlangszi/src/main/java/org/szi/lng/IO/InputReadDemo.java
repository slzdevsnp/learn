package org.szi.lng.IO;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/24/2012
 * Time: 1:11 PM
 * To change this template use File | Settings | File Templates.
 */

public class InputReadDemo {

    static void readTerminalInput(){
        System.out.print("What's your name? ");

        /*
         * Set up so that we can do line-oriented character reads
         * from the standard input stream.
         */

        BufferedReader input = new BufferedReader(
                new InputStreamReader(System.in) );

        try {
            String name = input.readLine();
            System.out.println("Hello, " + name + "!");
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
    public static void main(String[] args) {
     readTerminalInput();
    }
}
