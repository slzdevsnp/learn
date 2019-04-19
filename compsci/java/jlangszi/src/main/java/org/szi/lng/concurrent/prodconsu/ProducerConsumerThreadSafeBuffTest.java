package org.szi.lng.concurrent.prodconsu;

import java.util.Random;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/28/2012
 * Time: 7:29 AM
 * To change this template use File | Settings | File Templates.
 */


class ThreadSafeIntBuffer {
    private int   index;
    private int[] buffer = new int[8];

    boolean exitFlag = false;

    public synchronized void add( int num ){    //synchronized method
        while( index == buffer.length - 1 ){  //cannot add at right of the array
            try {
                wait();             //hang here
            }
            catch( InterruptedException e ){
            }
        }

        buffer[index++] = num;    //operation which add element
        notifyAll();              //pass control to other threads
    }

    public synchronized int remove(){   //synchronized method
        while( index == 0 ){              //cannot remove at left of an array
            try {
                wait();                 //hang here
            }
            catch( InterruptedException e ){
            }
        }
        int ret = buffer[--index]; //operation which removes element
        notifyAll();       //pass control to other threads
        return ret;
    }
    public void setExitFlag(){
        exitFlag = true;
    }
}

class Producer implements Runnable {
    private ThreadSafeIntBuffer buffer;
    private long maxCount;
    private long counter;
    public Producer( ThreadSafeIntBuffer buffer, long maxCount ){
        this.buffer = buffer;
        this.maxCount = maxCount;
        this.counter= 0;
    }
    public void run(){
        Random r = new Random();
        while( true ){      //inifinte loop
            if( buffer.exitFlag ){ break ; } // finish thread on exit condition
            int num = r.nextInt();
            buffer.add( num );
            System.out.println( "Produced " + num );
            counter++;
            if (counter == maxCount) {
                System.out.println("production maxCount of "+ maxCount +  " reached.");
                buffer.setExitFlag();
            } //  condition to end production
        }
    }
}

class Consumer implements Runnable {
    private ThreadSafeIntBuffer buffer;

    public Consumer( ThreadSafeIntBuffer buffer ){
        this.buffer = buffer;
    }

    public void run(){
        while( true ){     //infinite loop
            if(buffer.exitFlag) { break ; }  // finish thread on exit condition
            int num = buffer.remove();
            System.out.println( "Consumed " + num );
        }
    }
}


class ProducerConsumerThreadSafeBuffTest {

    static void testProdConsume(){
        long maxCount = 1000;
        ThreadSafeIntBuffer b = new ThreadSafeIntBuffer();
        Producer p = new Producer(b,maxCount);
        Consumer c = new Consumer(b);
         Thread t1 = new Thread(p,"Prod thread");
         Thread t2 = new Thread(c, "Cons thread");
         t1.start();
         t2.start();
    }

    public static void main(String[] args) {
        testProdConsume();
    }

}
