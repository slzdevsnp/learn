package org.szi.lng.concurrent5;

//needs debugging

import java.util.*;
import java.util.concurrent.*;

   public class ExchangerTest {

     private static final int FULL = 10;
     private static final int COUNT = FULL * 2;


     private static final Random random = new Random();
     private static volatile int sum = 0;
     private static Exchanger<List<Integer>> exchanger = new Exchanger<List<Integer>>();
     private static List<Integer> initiallyEmptyBuffer;        //data object
     private static List<Integer> initiallyFullBuffer;         //data object
     private static CountDownLatch stopLatch = new CountDownLatch(2);  //two threads

     private static class FillingLoop implements Runnable {
       public void run() {
         List<Integer> currentBuffer = initiallyEmptyBuffer;
         try {
           for (int i = 0; i < COUNT; i++) {
             if (currentBuffer == null )  {
               break; // stop on null  or mx number of refills
             }
             Integer item = random.nextInt(100);
             System.out.println("Added: " + item);
             currentBuffer.add(item);          //add item on the end
             if (currentBuffer.size() == FULL){        //condition to exchange thread
               currentBuffer =
                 exchanger.exchange(currentBuffer);
             }
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
         try {
           for (int i = 0; i < COUNT; i++) {
               if ( currentBuffer == null ){
                 break; // exit condition
               }
               if (currentBuffer.isEmpty()) {       //condition to exchange thread
                 currentBuffer =
                    exchanger.exchange(currentBuffer);
               }
               Integer item = currentBuffer.remove(0); //get away 1 element
               System.out.println("Got: " + item);
               sum += item.intValue();
           }
         } catch (InterruptedException ex) {
           System.out.println("Bad exchange on emptying side");
         }
         stopLatch.countDown();
       }
     }

     public static void main(String args[]) {
       initiallyEmptyBuffer = new ArrayList<Integer>();
       initiallyFullBuffer = new ArrayList<Integer>(FULL);
        //initialization blocks  the exchanger

       for (int i=0; i<FULL-1; i++) {    // if i<FULL thread gets stack
         initiallyFullBuffer.add(random.nextInt(100));
       }


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
