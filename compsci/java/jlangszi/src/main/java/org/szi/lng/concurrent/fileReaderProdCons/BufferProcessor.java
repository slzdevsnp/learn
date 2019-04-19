package org.szi.lng.concurrent.fileReaderProdCons;

/**
 * Created by IntelliJ IDEA.
 * User: slava
 * Date: Apr 20, 2009
 * Time: 5:09:57 PM
 * To change this template use File | Settings | File Templates.
 */
public class BufferProcessor implements Runnable{

    private  int result;
    private  int tempRes;
    private  TextBuffer ltb;

    public BufferProcessor(TextBuffer tb){
          result  = 0;
          ltb = tb;
    }
    public void run(){

        synchronized (ltb){

            while( true){
                if (ltb.isEof) break; //exit on end

                try{
                    System.out.println("Thread-"+ Thread.currentThread().getName()+" wating");
                    ltb.wait();       // here control over ltb should pass to BufferReader
                    System.out.println("Thread-"+ Thread.currentThread().getName()+" resumed");
                }catch(InterruptedException e){}

                 //do processing stats
                tempRes = 0;


                //iterate over ltb
                for (String s : ltb.buffer) {
                //    System.out.println("###" + s);
                    tempRes += s.length();
                }

                result +=tempRes;
                //System.out.println("current result="+result);
                
                // processing finishes

                // ! removing elements from buffer  after processing
                ltb.buffer.clear();
                //System.out.println("Thread-"+ Thread.currentThread().getName()+" ltb buffer cleared");
                //System.out.println("Thread-"+ Thread.currentThread().getName()+" notifyAll()");
                ltb.notifyAll(); // pass lft flow over to reader thread

            }
        
        }
        //print final stats
        System.out.println("Number of chars in text file is "+ result);
    }
}
