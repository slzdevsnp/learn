package org.szi.lng.concurrent5;

/**
 * User: szi
 * Date: 11 juin 2009
 * Time: 02:44:29
 */
  import java.util.concurrent.Semaphore;
  import java.util.*;

public class SemaphoreTest {
    private static final int LOOP_COUNT = 100;
     private static final int MAX_AVAILABLE = 2;

     private final static Semaphore semaphore = new Semaphore(MAX_AVAILABLE, true);

    //inner class
     private static class Pricer {
       private static final Random random = new Random();
       public static int getGoodPrice() {
         int price = random.nextInt(100);
         try {
           Thread.sleep(0,1);
         } catch (InterruptedException ex) {
           ex.printStackTrace();
         }
         return price;
       }
       public static int getBadPrice() {
         return 20;
       }
     }

     public static void main(String args[]) {
       for (int i=0; i<LOOP_COUNT; i++) {
         final int count = i;
         new Thread() {
           public void run() {
             int price;
             if (semaphore.tryAcquire()) {
               try {
                 price = Pricer.getGoodPrice();
               } finally {
                 semaphore.release();
               }
             } else {
               price = Pricer.getBadPrice();
             }
             System.out.println(count + ": " + price);
           }
         }.start();
       }
     }
}
