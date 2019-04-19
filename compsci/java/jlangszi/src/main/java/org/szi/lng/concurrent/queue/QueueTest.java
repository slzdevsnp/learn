package org.szi.lng.concurrent.queue;

import java.util.List;
import java.util.ArrayList;
import java.util.Random;
import java.nio.channels.FileChannel;
import java.nio.ByteBuffer;
import java.io.FileOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
/**
 * User: szi
 * Date: 11 juin 2009
 * Time: 14:40:27
 *
 * Producer consumer with pre 5 Threads
 */
public class QueueTest {
    protected static final int TOTALCOUNT = 3;
    protected static final int MIN_LENGTH = 10;
    protected static final int FRESH_LENGTH = 20;
    protected static final Random random = new Random();

    private static class QSignal{
            protected boolean dataSizeShort;
            protected boolean isFreshLengtMax;
            protected  boolean dataAtEnd;

        //constructor
        QSignal(){
            dataSizeShort = true;
            dataAtEnd = false;

        }
        
        public synchronized  boolean sizeTooShort(){
            return dataSizeShort;
        }
        public synchronized  void setSizeTooShort(boolean flag){
            dataSizeShort = flag;
        }
        public synchronized  boolean dataAtEnd(){
            return dataAtEnd;
        }
        public synchronized  void setDataAtEnd(boolean flag){
            dataAtEnd = flag;
        }
    }

    private static class Producer implements Runnable{
       private List<Integer> freshQueue;
       private List<Integer> mainQueue;
       private QSignal qState;
        Producer(List<Integer> fq, List<Integer>mq, QSignal qs){
            freshQueue = fq;
            mainQueue = mq;
            qState = qs;
        }
        public void run(){
            synchronized(qState) {
                int runCount = 0;
                while(true){
                    if (qState.dataAtEnd())
                        break;   // end of producing
                    for (int i = 0; i < FRESH_LENGTH; i++ ){
                        Integer item = random.nextInt(100);
                        freshQueue.add(item);
                        System.out.println("Producer added to freshQ: " + item + " runCount " + runCount);
                    }
                    runCount++;
                    if (runCount == TOTALCOUNT)
                        qState.setDataAtEnd(true);

                    mainQueue.addAll(freshQueue);   //dangerous
                    freshQueue.clear();

                    if (mainQueue.size() > MIN_LENGTH)
                        qState.setSizeTooShort(false);

                    try{
                        if (qState.sizeTooShort() == false || qState.dataAtEnd() == true ){
                            qState.notifyAll();
                            if (qState.dataAtEnd())
                                break;
                            System.out.println("Producer: enters in waiting");
                            qState.wait();
                            System.out.println("Producer: resuming");
                        }
                    }catch(InterruptedException ex){
                        System.out.println("Interrupt Exception in Receiver");
                    }
                }
            }//syncrho finished
        }
    }

    private static class Receiver implements Runnable{

         private List<Integer> mainQueue;
         private QSignal qState;
         private boolean dataFinished;
         private String outFname;
          Receiver(List<Integer>mq,QSignal qs, String fname){
              mainQueue = mq;
              qState = qs;

              dataFinished = false;
              outFname = fname;
          }


      public void run(){
        FileChannel fc = outputOpen(outFname);
        long count=0;
        synchronized (qState){
            while (true){
                if (dataFinished)
                    break;  //all data was processed
                count++;
                try{
                    if (qState.sizeTooShort()){
                        qState.notifyAll(); // pass control to producer
                        System.out.println("Receiver suspended. queue length: " + mainQueue.size());
                        qState.wait(); //control passed to producer, to update mainQueue
                        System.out.println("Receiver resumed. queue length: " + mainQueue.size());
                    }
                    Integer item = mainQueue.remove(0);
                    //item must sleep a random time up to 5 milliseconds
                    long sleepTime = new Long( random.nextInt(5)  ).longValue();
                    Thread.sleep(sleepTime);

                         //processing item

                      //item.notifyAll();

                        //processing item finished

                    //  debug write items with timestamp with 0.1 ms precision
                    //   3 last digits of the first field  203  means  20.3 ms
                    String s = "Receiver consumed: "  + item + " count:" + count + "\n";
                    outputWriteString(fc,s);

                    if (mainQueue.size() < MIN_LENGTH && qState.dataAtEnd()==false)
                        qState.setSizeTooShort(true);
                    if (mainQueue.isEmpty())
                         dataFinished = true;

                }catch(InterruptedException ex){
                        System.out.println("Receiver interrupted exception");
                }
            }
        } //synchro finished
          ouputClose(fc);
      }
    }
        static FileChannel outputOpen(String fname) {
            try{
                FileOutputStream fout = new FileOutputStream( fname );
                FileChannel fcout = fout.getChannel();
                return fcout;
            }catch(FileNotFoundException fe){
                fe.printStackTrace();
                return null;
            }
        }
        static void outputWriteString(FileChannel fc, String s){
            try{
                long nanoTime = System.nanoTime();
                long lowerTime =  nanoTime / 100000; //0.1 of milliseconsd
                String tprefix = new Long(lowerTime).toString();
                s = tprefix +" " + s;
                byte data[] = s.getBytes();
                ByteBuffer bb = ByteBuffer.wrap(data);
                fc.write(bb);   //write data
            }catch(IOException ioe){
                ioe.printStackTrace();
            }
        }
        static void ouputClose(FileChannel fc) {
            try {
                fc.close();
            } catch (IOException ioe) {
                ioe.printStackTrace();
            }
        }

    public static void main(String[] args) {

        List<Integer> queue = new ArrayList<Integer>();
        List<Integer> freshQueue = new ArrayList<Integer>(FRESH_LENGTH);
        final QSignal qState = new QSignal();
        String outDebugFile = "/tmp/queuetest.txt";
        new Thread(new Producer(freshQueue,queue,qState)).start();
        new Thread(new Receiver(queue,qState,outDebugFile)).start();
        

    }
}
