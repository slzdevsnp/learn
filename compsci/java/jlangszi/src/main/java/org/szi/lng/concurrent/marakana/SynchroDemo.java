package org.szi.lng.concurrent.marakana;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/25/2012
 * Time: 8:57 AM
 * To change this template use File | Settings | File Templates.
 */

class Counter {
    private int acount = 0;
    private int bcount = 0;
    public void setACount(int count) { this.acount = count; }
    public int getACount() { return this.acount; }

    public int getBcount() {
        return bcount;
    }
    public synchronized  void setBcount(int bcount) {     //syncrho method
        this.bcount = bcount;
    }
}



class Crunner implements Runnable{
    private final int maxCount;
    private final  Counter counter;    //business object which is accessed by threads

    Crunner(int maxCount, Counter counter) {
        this.counter = counter;
        this.maxCount = maxCount;
    }

    public void run() {
      for(int i = 0; i<this.maxCount;i++){
          int currentCount;
          synchronized(this.counter){
              currentCount = this.counter.getACount();
              currentCount++;
              this.counter.setACount(currentCount);
          }
          System.out.println(Thread.currentThread().getName() + " at acount " + currentCount);
      }
          //whithout synchronized block
      for(int j = 0;j<this.maxCount;j++){
              int currentCount;
              currentCount = this.counter.getBcount();
              currentCount++;
              this.counter.setBcount(currentCount); //calling synchronized method
          System.out.println(Thread.currentThread().getName() + " at bcount " + currentCount);
      }
    }
}


class SynchroDemo {

     public static void main(String[] args) {
         final int MAXCNT = 100;
          Thread  t1 = new Thread(new Crunner(MAXCNT, new Counter()));
          Thread  t2 = new Thread(new Crunner(MAXCNT, new Counter()));
          t1.start();
          t2.start();

    }
}
