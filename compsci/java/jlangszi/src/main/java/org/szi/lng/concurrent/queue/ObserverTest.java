package org.szi.lng.concurrent.queue;

/**
 * User: szi
 * Date: 12 juin 2009
 * Time: 11:50:40
 */
public class ObserverTest {

    static class Observer implements Runnable{
       private volatile boolean threadFinished;
       private volatile boolean isItemReady;
       private Integer item;

        Observer(){
            threadFinished = false;
            isItemReady = false;
        }


        public Integer getItem() {
            return item;
        }
        public synchronized void setItem(Integer item) {     //modifies item in observer (syncrhnized)
            this.item = item;
            isItemReady = true;
            notify();
        }

        public synchronized void  setThreadFinished() {
            this.threadFinished = true;
            notify();
        }

        private synchronized void doProcessing(Thread th){
            System.out.println(th.getId()+" id  processing item: "+item);
               isItemReady = false;

        }

        public void run(){

            Thread thisThread = Thread.currentThread();
            synchronized(this){
                while (true) {
                    try {
                        if(!isItemReady)
                                wait();

                        if (threadFinished)
                             break;

                        //processing
                        doProcessing(thisThread);

                    } catch (InterruptedException e){
                        e.printStackTrace();
                    }
                }
            }
        }        
    }

    public static void main(String[] args) {
        try{
        long stime = 3;
            Observer  obs = new Observer();
            Thread observerT = new Thread(obs);
        
            observerT.start();

            obs.setItem(new Integer(2));
            Thread.sleep(stime);
            obs.setItem(new Integer(4));
            Thread.sleep(stime);
            obs.setItem(new Integer(6));
            Thread.sleep(stime);
            obs.setThreadFinished();   //cond to get out of Observer.run()
        }catch(InterruptedException e){}
    }
}
