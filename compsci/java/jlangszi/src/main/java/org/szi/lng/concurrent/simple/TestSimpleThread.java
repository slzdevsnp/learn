package org.szi.lng.concurrent.simple;

import org.szi.lng.timer.ProfileTimer;
import java.util.List;
import java.util.LinkedList;

/**
 * Created by IntelliJ IDEA.
 * User: slava
 * Date: Mar 6, 2009
 * Time: 1:47:12 AM
 * To change this template use File | Settings | File Templates.
 */
public class TestSimpleThread {

    public static  void main(String[] args){
        launchSingleThread();

        //launchManyThreads(true);
    }

    private static void launchManyThreads(boolean withPriority){
        int NUMTRHEADS = 10;

        int threadPriority = Thread.MIN_PRIORITY;


        Thread t[] = new Thread[NUMTRHEADS];

        System.out.println("thread min prio, max prio:" + Thread.MIN_PRIORITY + " " + Thread.MAX_PRIORITY);

        // initialize threads
        for(int i = 0; i < t.length; ++i){
            t[i] = new Thread(new SimpleRunnable(),"Thread "+i);
            if (withPriority){
                int cPrio = threadPriority +  i;
//                if (i == 9)  cPrio = Thread.MAX_PRIORITY;
                t[i].setPriority(cPrio);
                System.out.println("cur thread prio: " + cPrio);
            }
        }
        // launch threads
        for(int i = 0; i < t.length; ++i){
            t[i].start();
            System.out.println(t[i].getName()+" started");
        }

    }


    private static void launchSingleThread(){

        ProfileTimer.start("method 1 directComputation");
        directComputation();

        ProfileTimer.start("method 2 launchDirectThread");
        launchDirectThread();

        ProfileTimer.start("method 3 launchRunnable");
        launchRunnable();

        ProfileTimer.end();

        ProfileTimer.printTimings();

    }

    private static void launchDirectThread(){

        SimpleThread st = new SimpleThread();
        st.start();
    }

    private static void launchRunnable(){
        Runnable r =  new SimpleRunnable();
        Thread t = new Thread(r);
        t.start();
    }

    private static void directComputation(){
        List<Long> li = new LinkedList();
        long sum = 0;
        long isum = 0;
        final long  uplim = 1000000;
        for (int i = 0; i < uplim ; ++i){
            sum+=i;
            li.add(new Long(sum));
        }
        System.out.println("sum: "+sum + "\n");
        //optimize memory
        li = null;  //get rid of linked list
        Runtime.getRuntime().gc();
    }


}
