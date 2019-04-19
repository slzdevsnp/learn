package org.szi.lng.concurrent.marakana;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/25/2012
 * Time: 7:21 AM
 * To change this template use File | Settings | File Templates.
 */
class ThreadDemo{


    static void launchThreads(int nthreads, int ncount) throws InterruptedException {
        Thread[] threads = new Thread[nthreads]; //array of Thread
        System.out.println("Creating threads");
        for(int i=0;i<threads.length;i++){
            threads[i] = new Thread( new Runner("Runner " + i, ncount));
        }
        System.out.println("Starting threads");
        for(int i=0;i<threads.length;i++){ threads[i].start();  }

        System.out.println("Waiting for threads");
        for(int i=0;i<threads.length;i++){ threads[i].join();  }   //join() waits for this thread to die

        System.out.println("DONE");
    }


    public static void main(String[] args) throws InterruptedException {
        final int numThreads = 4;
        final int count = 2;
        launchThreads(numThreads, count);
    }

}

class Runner implements Runnable {
    private final String name;
    private final int count;
    public Runner(String name, int count) {
        this.name = name; this.count = count;
    }
    public void run() {
        for (int i = 0; i < count; i++) {
            System.out.println("running " + name + "=" + i);
            Thread.yield(); // static method, causes current thread to temporarily pause and allow others to execute
        }
    }
}

