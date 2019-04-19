package org.szi.lng.concurrent.daemon;

/**
 * Created by IntelliJ IDEA.
 * User: slava
 * Date: Mar 6, 2009
 * Time: 6:49:00 PM
 * To change this template use File | Settings | File Templates.
 */
public class TestDeadLockDemo {


    public final static Object one = new Object();
    public final static Object two = new Object();

    public static void main(String[] args){
        // launch 2 competing threads
        Thread t1 = new Thread(){
            public void run(){
                //block 1st obj
                synchronized(one){
                    try{
                        Thread.sleep(1);
                        System.out.println("t1 got here");
                        //block 2nd obj
                        synchronized(two){
                            System.out.println("t1 Success!");
                        }
                    }catch (InterruptedException ie) {};
                }
            }
        };
        Thread t2 = new Thread(){
             public void run(){
                 //block 2st obj
                 synchronized(two){
                    try{
                        Thread.sleep(1);
                        System.out.println("t2 got here");
                        //block 1st obj
                        synchronized(one){
                            System.out.println("t2 Success!");
                        }
                    }catch (InterruptedException ie) {};
                 }
             }
         };

        //lauch two threads
        t1.start();
        t2.start();
    }   
}
