package org.szi.lng.concurrent.notify;

/**
 * Created by IntelliJ IDEA.
 * User: slava
 * Date: Apr 20, 2009
 * Time: 4:36:44 PM
 * To change this template use File | Settings | File Templates.
 */
public class ThreadNotified implements Runnable{
    static private Object oShared = new Object();

    private int type;

    public ThreadNotified(int i){  //constructor
        type = i;
    }

    public void run(){
        if (type == 1 || type ==2 ){
            synchronized (oShared){
                try{
                    System.out.println("Thread-"+ Thread.currentThread().getId()+" wating");
                    oShared.wait();
                }catch(InterruptedException e){}

                System.out.println("Thread-"+ Thread.currentThread().getId()+" type="+type+" after wait()");
            }
        }else{
            synchronized (oShared){
                //for type > 2
                oShared.notifyAll();
                System.out.println("Thread-"+ Thread.currentThread().getId()+" type="+type+" after notifyAll()");
             }
        }
    }

    

}
