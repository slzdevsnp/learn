package org.szi.lng.concurrent5;

import java.util.Random;
import java.util.List;
import java.util.ArrayList;
import java.util.concurrent.Exchanger;
import java.util.concurrent.CountDownLatch;

/**
 * User: szi
 * Date: 14 juin 2009
 * Time: 15:31:21
 */

    import java.util.ArrayList;
    import java.util.List;


    import java.util.*;
    import java.util.concurrent.*;
import java.nio.channels.FileChannel;
import java.nio.ByteBuffer;
import java.io.FileOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

public class ExhangerTestTimeDebug {

         private static final int FULL = 100;
         private static final int COUNT = FULL * 6;

         private static final Random random = new Random();
         private static volatile int sum = 0;
         private static Exchanger<List<Integer>> exchanger =
           new Exchanger<List<Integer>>();
         private static List<Integer> initiallyEmptyBuffer;
         private static List<Integer> initiallyFullBuffer;
         private static CountDownLatch stopLatch =
           new CountDownLatch(2);

         private static class FillingLoop implements Runnable {
           public void run() {
             List<Integer> currentBuffer = initiallyEmptyBuffer;
             try {
               for (int i = 0; i < COUNT; i++) {
                 if (currentBuffer == null)
                   break; // stop on null
                 Integer item = random.nextInt(100);
                 System.out.println("Added: " + item);
                 currentBuffer.add(item);
                 if (currentBuffer.size() == FULL)
                   currentBuffer =
                     exchanger.exchange(currentBuffer);
               }
             } catch (InterruptedException ex) {
               System.out.println("Bad exchange on filling side");
             }
             stopLatch.countDown();
           }
         }

         private static class EmptyingLoop implements Runnable {

           public void run() {
             List<Integer> currentBuffer = initiallyFullBuffer;
             String fname = "/tmp/exchanger_test.txt";
             FileChannel fc = outputOpen(fname);
             int count = 0;
             try {
               for (int i = 0; i < COUNT; i++) {
                   if (currentBuffer == null)
                     break; // stop on null

                   if (currentBuffer.isEmpty()) {
                       count = 0;
                     currentBuffer =
                        exchanger.exchange(currentBuffer);

                   }
                   Integer item = currentBuffer.remove(0);
                    count++;
                    String s = "Got: " + item + " " + count + "\n";
                    outputWriteString(fc,s);
                    //System.out.println("Got: " + item);
                   sum += item.intValue();
               }
             } catch (InterruptedException ex) {
               System.out.println("Bad exchange on emptying side");
             }
             stopLatch.countDown();
             ouputClose(fc);
           }
             FileChannel outputOpen(String fname) {
                 try{

                     FileOutputStream fout = new FileOutputStream( fname );
                     FileChannel fcout = fout.getChannel();
                     return fcout;
                 }catch(FileNotFoundException fe){
                     fe.printStackTrace();
                     return null;
                 }
             }
              void outputWriteString(FileChannel fc, String s){
                 try{
                     long nanoTime = System.nanoTime();
                     long lowerTime =  nanoTime / 100000; //0.1 of milliseconsd
                     String tprefix = new Long(lowerTime).toString();
                     s = tprefix +" " + s;
                     byte data[] = s.getBytes();
                     ByteBuffer bb = ByteBuffer.wrap(data);
                     fc.write(bb);   //write data
                 }catch(IOException ioe){
                     ioe.printStackTrace();
                 }
             }

              void ouputClose(FileChannel fc){
             try{
                 fc.close();
             }catch(IOException ioe){
                 ioe.printStackTrace();
             }
         }

         }

         public static void main(String args[]) {
           initiallyEmptyBuffer = new ArrayList<Integer>();
           initiallyFullBuffer = new ArrayList<Integer>(FULL);
           /*for (int i=0; i<FULL; i++) {
             initiallyFullBuffer.add(random.nextInt(100));
           }
           */
           new Thread(new FillingLoop()).start();
           new Thread(new EmptyingLoop()).start();
           try {
             stopLatch.await();
           } catch (InterruptedException ex) {
               ex.printStackTrace();
           }
           System.out.println("Sum of all items is.... " + sum);
         }
       }

