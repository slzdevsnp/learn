package org.szi.lng.concurrent.daemon;

import org.szi.lng.concurrent.daemon.TestDaemon;

/**
 * Created by IntelliJ IDEA.
 * User: slava
 * Date: Mar 6, 2009
 * Time: 4:28:58 PM
 * To change this template use File | Settings | File Templates.
 */
public class DaemonDemo extends Thread {

     public DaemonDemo(){
         super("Daemon demo thread");
         setDaemon(true);
         start();
     }

    public void run(){
        int NUMTHREADS = 10;
        Thread threads[] = new Thread[NUMTHREADS];

        while(true){
            // get threads from the group
            int count = TestDaemon.GROUP.activeCount();
            if (threads.length < count)
                threads = new Thread[count + NUMTHREADS];

            count = TestDaemon.GROUP.enumerate(threads);

            // print all threads
            for (int i = 0; i< count ; ++i){
                System.out.print(threads[i].getName()+", ");
            }
            System.out.println();
            try{
                Thread.sleep(100);
            }catch(InterruptedException e){}
        }
    }
}
