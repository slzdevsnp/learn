package org.szi.lng.concurrent.simple;

import org.szi.lng.timer.ProfileTimer;

import java.util.List;
import java.util.LinkedList;

/**
 * Created by IntelliJ IDEA.
 * User: slava
 * Date: Mar 6, 2009
 * Time: 1:44:56 AM
 * To change this template use File | Settings | File Templates.
 */
public class SimpleThread  extends Thread {
    public void run(){

        System.out.println("started SimleThread\n");
        List<Long> li = new LinkedList();
        final long  uplim = 1000000;
        long sum = 0;
        long isum = 0;
        for (int i = 0; i < uplim ; ++i){
            sum+=i;
            li.add(new Long(sum));
        }
        System.out.println("sum: "+sum + "\n");
        //optimize memory
        li = null;
        Runtime.getRuntime().gc(); //launch garbage coll
        

    }
}
