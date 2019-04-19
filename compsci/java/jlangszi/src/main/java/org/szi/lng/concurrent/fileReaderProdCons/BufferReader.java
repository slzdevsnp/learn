package org.szi.lng.concurrent.fileReaderProdCons;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

/**
 * Created by IntelliJ IDEA.
 * User: slava
 * Date: Apr 20, 2009
 * Time: 5:09:31 PM
 * To change this template use File | Settings | File Templates.
 */
public class BufferReader implements Runnable {
    private String filePath;
    private TextBuffer ltb;

    static int BUFFERLENGTH; // 10000
    //const
    public BufferReader(String f, TextBuffer tb, int buflength){
        filePath = f;
        ltb = tb;
        BUFFERLENGTH = buflength;
    }

    public void run(){

       synchronized (ltb){  ///!!!
           BufferedReader inputStream = null;

           try {
               inputStream =  new BufferedReader(new FileReader(filePath));
               String l;
               int lcount=0;
               while (true){       //infinite loop
                   l = inputStream.readLine();
                   if (l == null)
                       ltb.isEof = true;
                   if (! ltb.isEof){
                       ltb.buffer.add(l);
                       lcount++;
                   }
                   // pass control to other thread when buffer limit is reached or end of file reached
                   if (lcount >= BUFFERLENGTH || ltb.isEof )
                   {
                       lcount = 0;      // reset line counter
                       //System.out.println("Thread-"+ Thread.currentThread().getName()+" notifyAll()");
                       ltb.notifyAll(); // pass lft flow over to another thread   using shared object
                       if (ltb.isEof)
                           break;
                       System.out.println("Thread-"+ Thread.currentThread().getName()+" waiting");
                       ltb.wait();      // stop this thread  using shared object
                       System.out.println("Thread-"+ Thread.currentThread().getName()+" resumed");

                   }
               }

           //after processing close fileHandle
           if (inputStream != null)
               inputStream.close();
        }
        catch(InterruptedException e){}
        catch (IOException e) {
	      System.err.println("Caught IOException: "
	                      + e.getMessage());
        }


       }
    }
}
