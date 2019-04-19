package org.szi.lng.dsalgo;

import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 10/13/2012
 * Time: 6:04 AM
 * To change this template use File | Settings | File Templates.
 */



class Node<V>{
    protected V item;
    protected Node next;
    //constr
    Node( V it){
        this.item = it;
    }
    public V getNodeContent() { return this.item;}
}

class SQueue<V>{
    private Node<V> head = null;
    private Node<V> tail = null;
    private long cnt = 0;   // numnber of current elements in queue
    private boolean isAbort = false; // flag to exit
    //will be using default  constructor

    public synchronized void  enqueue(V in){
        // we can pput in queue as many nodes as we wish
        Node<V> nd = new Node(in);
         if ( head == null){ // empty queue
            head  = nd;      // make fresh queue with 1 element
            tail = nd;
         }else{  //queue is not empty
           Node lt = tail;  // previous tail
           lt.next = nd;    // link prev tail next to inserted element
           tail = nd;       // set new tail
         }
         cnt++;  // increment number of nodes in queue
         notifyAll(); //pass control to other threads
    }

    public  synchronized V dequeue(){
        while( cnt == 0){
            try{
                wait();    //thread sleeps while queue has no elements
            }catch (InterruptedException e) {}
        }
        Node<V> first = head; // node to return
        //  empty queue
        if( first == null) { // this state should never happen  due to thread sleeping
            throw new IllegalStateException("Cannot dequeue from an empty queue");
        }
        head = first.next;
        cnt--;         //decrement number of nodes in queue
        if (head == null){    //only 1 element was present
            tail = null;     // queue is empty now
            assert cnt == 0;
        }
        notifyAll();
        return first.item;
    }

    public boolean isEmptyQueue(){ return (head == null); }
    public long  getNumberOfNodes(){ return cnt;}
    public String toString(){
        Node<V> ce = head;
        StringBuffer sb = new StringBuffer();
        if (ce == null) {
            sb.append("empty queue");
        }else{
          sb.append("queue: {");
          while(true){
              sb.append(ce.item.toString()+", ");
              if( ce.next == null) {    break; }
              ce = ce.next;  // move to next element
          }
          sb.append("}");
        }
        return( sb.toString());
    }
    // getter setter for abort flag
    public synchronized void setAbort(){ this.isAbort = true;}
    public boolean isAbort() { return this.isAbort;}
}
//dummy quote object
class DQuote{
   private String market;
   private String ticker;
   private double price;
    DQuote(String market, String ticker, double price){
        this.market = market;
        this.ticker = ticker;
        this.price = price;
    }
    public String toString(){
        return  "quote market: " + market + " ticker: " + ticker + " price: " + price;
    }
    public String getStrId(){
         return market + "_" + ticker;
    }
}

class DQuoteRandProducer implements Runnable{
    private SQueue<DQuote> qu ;
    private long maxProduced;
    private long produceCnt;
    long seed;

    //construct
    DQuoteRandProducer(long maxProduce, long seed, SQueue<DQuote> q){
        this.qu = q;
        this.maxProduced = maxProduce;
        this.seed = seed;
        this.produceCnt = 0;
    }
    /// dummy logic to generate few different quotes
    private DQuote genDummyQuote(double d){
        DQuote qt = null;
        if ( d <= 0.25) { qt = new DQuote("NYSE","GE", d);}
        else if( d > 0.25 && d <= 0.5) { qt = new DQuote("NASDAQ","HPQ", d); }
        else if( d > 0.5 && d <= 0.75) { qt = new DQuote("NASDAQ","AAPL", d); }
        else                           {  qt = new DQuote("NYSE", "SBUX", d); }
        return qt;
    }
    public void run(){
        Random r = new Random(seed);
        while(true){   //inf loop
          //loop exit condition
         if( produceCnt >= maxProduced)  {
             qu.setAbort(); // set abort flag for a queue
             System.out.println("{Max limit of elements to produce reached");
             break;  //finish thread
         }
         double d = r.nextDouble();
         DQuote cqt = genDummyQuote(d);
         qu.enqueue(cqt);    //synchronized method
         produceCnt++;
        }
    }
}
//@deprecated
class DQuoteConsumer implements  Runnable {
    private SQueue<DQuote> qu;
    //construct
    DQuoteConsumer(SQueue<DQuote> q) { this.qu = q;}
    public void run(){
        while(true){  //working loop
        if (qu.isAbort() && qu.isEmptyQueue() ) { break; }  //terminate thread
        DQuote  q = qu.dequeue();      //synchronized method
        /////dispatching zone  for DQuote object
        System.out.println("deb: consumed " + q.toString());
       }
    }
}
class DQuoteDispatcher implements  Runnable {
    private SQueue<DQuote> qu;
    private UserSubscription  usub;
    //construct
    DQuoteDispatcher(SQueue<DQuote> q, UserSubscription usub) {
        this.qu = q;
        this.usub = usub;
    }
    public void run(){
        while(true){  //working loop
            if (qu.isAbort() && qu.isEmptyQueue() ) { break; }  //terminate thread
            DQuote  qt = qu.dequeue();      //synchronized method
           // System.out.println("deb: quote rcvd: " + qt.toString());
            /////dispatching zone  for DQuote object
            if (usub.isSubscribed(qt.getStrId())){
                MarketProcessor mp  = MProcessorFactory.getProcessor(qt);
                if (mp != null){
                    mp.doProcess(qt);
                }
            }
        }
    }
}


interface MarketProcessor{
        public void doProcess(DQuote qt);
}
//specific processors
class MarketProcessorGE implements  MarketProcessor{
        public void  doProcess(DQuote qt){
            System.out.println("processorGE processing " + qt);
        }
}
class MarketProcessorAAPL implements  MarketProcessor{
    public void  doProcess(DQuote qt){
        System.out.println("processorAAPL processing " + qt);
    }
}
class MarketProcessorSBUX implements  MarketProcessor{
    public void  doProcess(DQuote qt){
        System.out.println("processorSBUX processing " + qt);
    }
}
class MarketProcessorHPQ implements  MarketProcessor{
    public void  doProcess(DQuote qt){
        System.out.println("processorHPQ processing " + qt);
    }
}

class MProcessorFactory{
    static Map<String,MarketProcessor> mprocs;
    static void initializeProcs(){
        mprocs = new HashMap<String,MarketProcessor>();
        mprocs.put("NYSE_GE", new MarketProcessorGE());
        mprocs.put("NASDAQ_AAPL", new MarketProcessorAAPL());
        mprocs.put("NYSE_SBUX", new MarketProcessorSBUX());
        mprocs.put("NASDAQ_HPQ", new MarketProcessorHPQ());
    }
    static MarketProcessor getProcessor(DQuote qt){
         MarketProcessor mp = mprocs.get(qt.getStrId());
         //if not initialized mp can be null
         return mp;
    }

}

class UserSubscription{
  private List<String> subs = new ArrayList<String>();
  void subscribe(String market, String ticker){
      String strid = market + "_" + ticker;
      if( !subs.contains(strid)){  subs.add(strid); }
  }
  boolean isSubscribed(String tikrid) {return subs.contains(tikrid);  }
 }

class SafeQueueTest {

   static void testQuoteProdCons(){
       long maxProduce = 100 ;
       long seed = 12345;

       SQueue<DQuote> q = new SQueue<DQuote>();
       DQuoteRandProducer p = new DQuoteRandProducer(maxProduce,seed,q);
       DQuoteConsumer  c = new DQuoteConsumer(q);
       Thread pt = new Thread(p,"producer");
       Thread ct = new Thread(c, "consumer");
       pt.start();
       ct.start();
   }

    static void testUserQuotesProc(){
        long maxProduce = 100 ;
        long seed = 12345;

        MProcessorFactory.initializeProcs(); // initialze all implemented marketprocessors
        UserSubscription us  = new UserSubscription();
        //add two tickers to user subscription
        us.subscribe("NYSE", "SBUX");
        us.subscribe("NASDAQ", "AAPL");
        //us.subscribe("NYSE", "GE");

        SQueue<DQuote> q = new SQueue<DQuote>();
        DQuoteRandProducer p = new DQuoteRandProducer(maxProduce,seed,q);
        DQuoteDispatcher  d = new DQuoteDispatcher(q,us);
        Thread pt = new Thread(p,"producer");
        Thread ct = new Thread(d, "dispatcher");
        pt.start();
        ct.start();


    }


    public static void main(String[] args) {

        //testQuoteProdCons();
        testUserQuotesProc();
    }
}
