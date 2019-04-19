package org.szi.lng.concurrent.sync;

import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;

/**
 * Created by IntelliJ IDEA.
 * User: slava
 * Date: Apr 20, 2009
 * Time: 2:51:21 PM
 * To change this template use File | Settings | File Templates.
 */
public class TestSynchronizedTreads implements Runnable
{

    private static List  shrdl = new ArrayList();


    public void operateOnObject()  // this method is executed in every thread
    {
       for (int i = 0; i< 10; i++){
           shrdl.add(new Integer(i));
           System.out.println("thrd_id="+Thread.currentThread().getId()); 
       }
        Thread.yield(); //temp stop
        
       //shrdl.remove(0); // get read of first element

       printList(shrdl, Thread.currentThread().getName());

    }
    public
    //helpper method
    void printList(List l, String message)
    {
        System.out.print(message+" ");
        System.out.print("List {");
        for (Iterator<Integer> it = l.iterator(); it.hasNext(); ){
            Integer in = it.next();
            System.out.print(in+", ");
        }
        System.out.println("}\n");
      }

    //  specify which methods is executed by threads
/*
    public void run(){
        synchronized(shrdl){
            operateOnObject(shrdl);
        }
    }

  */

    public void run(){
        operateOnObject();
    }
     


    // launch threads
    public static void main(String s[]){
       final int nthreads = 3;
       for (int i = 0; i < nthreads; i++){
           Thread t = new Thread(new TestSynchronizedTreads(), "Thread-"+i);
           t.start();
       }
    }
}
