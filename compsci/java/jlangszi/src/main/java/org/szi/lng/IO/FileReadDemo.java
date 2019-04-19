package org.szi.lng.IO;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/24/2012
 * Time: 12:31 PM
 * To change this template use File | Settings | File Templates.
 */
import java.io.*;

public class FileReadDemo {

    private static void read(File file) {
        try {
            FileInputStream fis = new FileInputStream(file);
            try {
                byte[] buffer = new byte[1024];
                int len = 0;
                while ((len = fis.read(buffer)) > 0) {
                    System.out.write(buffer, 0, len);
                }
            } finally {
                fis.close();
            }
        } catch (FileNotFoundException e) {
            System.err.println("No such file exists: " + file.getAbsolutePath());
        } catch (IOException e) {
            System.err.println("Cannot read file: "
                    + file.getAbsolutePath() + ": " + e.getMessage());
        }
    }

    private static void readDefault(File file) {
        try {
            FileReader reader = new FileReader(file);
            try {
                int ch;
                while ((ch = reader.read()) != -1) {
                    System.out.print((char) ch);
                }
                System.out.flush();
            } finally {
                reader.close();
            }
        } catch (FileNotFoundException e) {
            System.err.println("No such file exists: " + file.getAbsolutePath());
        } catch (IOException e) {
            System.err.println("Cannot read file: "
                    + file.getAbsolutePath() + ": " + e.getMessage());
        }
    }



    static void testReadFle(String fname){
        File  f  = new File(fname);
        read(f);
    }
    static void testReadDefaultFle(String fname){
        File  f  = new File(fname);
        readDefault(f);
    }




    public static void main(String[] args) {
          String fname = "/Users/zimine/.Rprofile";
          testReadFle(fname);
          testReadDefaultFle(fname); //same functionality read file char by char

    }
}
