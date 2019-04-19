package org.szi.lng.concurrent.daemon;

import org.szi.lng.concurrent.daemon.DaemonDemo;

/**
 * Created by IntelliJ IDEA.
 * User: slava
 * Date: Mar 6, 2009
 * Time: 3:33:25 PM
 * To change this template use File | Settings | File Templates.
 */
public class TestDaemon implements Runnable{

    // group to contain all tested threads
    public final static ThreadGroup GROUP = new ThreadGroup("Daemon demo");

    private int start;

    public TestDaemon(int s){
        start = (s % 2 ==0)? s : s+1;
        new Thread(GROUP, this, "Thread " +start).start();
    }

    public void run(){
        //reverse loop
        for (int i = start; i> 0; --i){
            try{
                Thread.sleep(100);
            }catch (InterruptedException e){}
            // in the middle start a new thread
            if (start > 2 && i == start/2)
                new TestDaemon(i);
        }
    }

    public static void main(String s[]){
        int NUMDAEMONS=16;
        new TestDaemon(NUMDAEMONS);
        new DaemonDemo();
    }


}
