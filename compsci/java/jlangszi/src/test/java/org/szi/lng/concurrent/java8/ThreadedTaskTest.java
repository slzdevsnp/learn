package org.szi.lng.concurrent.java8;

import static org.assertj.core.api.Assertions.*;
import org.assertj.core.api.Assertions;
import org.junit.*;


import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.*;



public class ThreadedTaskTest {

    private static final ExecutorService executor = Executors.newCachedThreadPool();
    private List<Integer> ilist;
    private OpStatus status;
    final int timeoutSeconds = 5;

    enum OpStatus{
        REFRESHED,
        UNREFRESHED,
        UNDEFINED
    }


    @AfterClass
    public static void tearDown(){
        try{
            executor.shutdown();
            executor.awaitTermination(1, TimeUnit.SECONDS); //giv tasks 1 secons to terminate
        }catch (InterruptedException e) {
            System.err.println("tasks interrupted");
        }finally{
            if (!executor.isTerminated()) {
                System.err.println("cancel non-finished tasks");
            }
            executor.shutdownNow();
        }
    }
    @Before
    public void setUp(){
        ilist= new ArrayList<>();
        status = OpStatus.UNDEFINED;

    }



/*
    Runnable threadNameTask = () -> {
        String threadName = Thread.currentThread().getName();
        System.out.println("hello, " + threadName);
    };


    @Test
    public void launchTaskInTwoThreadsTest(){
        threadNameTask.run(); // launch in a current thread;

        Thread thread = new Thread(threadNameTask);
        thread.start();
        System.out.println("both tasks launched");
        Assertions.assertThat(true);
    }

    @Test
    public void submitTwoTaskWithExecutor(){
        executor.submit(threadNameTask);
        executor.submit(threadNameTask);
        System.out.println("submited 2 threadNameTasks through the executor");
    }

*/
    private void updateList(){
        status = OpStatus.UNDEFINED;
        ilist.clear();
        ilist.add(1);
        ilist.add(2);
        ilist.add(3);
        status = OpStatus.REFRESHED;
        //2nd scenario  //comment it out
        /*
        list.clear();
        ilist.add(-1);
        ilist.add(-2);
        status = OpStatus.UNREFRESHED; */
    }

    Runnable refreshListTask = () -> {
        try {
            String threadName = Thread.currentThread().getName();
            System.out.println("реfreshing list in thread:" + threadName);
            TimeUnit.SECONDS.sleep(3);
            updateList(); // buz logic is done here
            System.out.println("refreshing list finished..");
        }catch  (InterruptedException e) {
            throw new IllegalStateException("task interrupted", e);
        }
    };
    Callable<OpStatus> statusTask = () -> {
        Instant start  =Instant.now();
        Instant current;
        status = OpStatus.UNDEFINED;
        String threadName = Thread.currentThread().getName();
        System.out.println("checking status in thread:" + threadName);
        try {
            do {

                TimeUnit.MILLISECONDS.sleep(500);
                current = Instant.now();
                System.out.println("current iteration status:" + status );
                if (status != OpStatus.UNDEFINED) {
                    return status;
                }
            }while (true);
        } catch (InterruptedException e) {
            throw new IllegalStateException("task interrupted", e);
        }finally {
            return status;
        }
    };


    @Test
    public void testSubmitCheckStatusInTasks() {
        try {
            String threadName = Thread.currentThread().getName();
            System.out.println("main flow in thread:" + threadName);
            executor.submit(refreshListTask);
            Future<OpStatus> future = executor.submit(statusTask);
            OpStatus result = future.get(timeoutSeconds,TimeUnit.SECONDS);  //current thread is block until future.isDone is true
            System.out.println("future done?" + future.isDone() + " lstatus:" + result);
            switch (result){
                case REFRESHED : System.out.println("ilist after refresh:" + ilist); break;
                case UNREFRESHED: System.out.println("ilist if not refreshed:"+ilist); break;
                default: System.out.println("ilist status is undefined within timeout");
            }
        } catch (TimeoutException|ExecutionException|InterruptedException e) {
            throw new IllegalStateException("task interrupted", e);
        }
    }

}
