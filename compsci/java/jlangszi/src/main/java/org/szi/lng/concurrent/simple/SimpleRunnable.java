package org.szi.lng.concurrent.simple;

import org.szi.lng.timer.ProfileTimer;

import java.util.List;
import java.util.LinkedList;

/**
 * Created by IntelliJ IDEA.
 * User: slava
 * Date: Mar 6, 2009
 * Time: 12:36:03 PM
 * To change this template use File | Settings | File Templates.
 */
public class SimpleRunnable implements Runnable {

    public void run(){

        double res = 0;
        for (int i = 0; i < 5000000 ; ++i){
            res = Math.sin(i*i);
        if (i%1000000==0) System.out.println(getName()+" counts " + i/1000000 ); 
        }

    }

    public String getName(){
        return Thread.currentThread().getName();   //static method from Thread pointing to the currently executing thread
    }
}
