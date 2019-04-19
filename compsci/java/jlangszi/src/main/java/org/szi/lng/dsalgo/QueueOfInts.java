package org.szi.lng.dsalgo;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/27/2012
 * Time: 2:22 PM
 * http://math.hws.edu/javanotes/c9/s3.html
 */
 class QueueOfInts {

    /// queue element inner class
    private static class Node {
        int item;
        Node next;
        Node(int n){
            this.item = n;
        }
    }

    //private members
    private Node head = null;  //queue head
    private Node tail = null;  //queue tail

    //no explicit constructor

    /**
     * add/push N to the back of the queue
     */
 
     public  void enqueue(int N){
         Node nd  = new Node(N);
         if (head == null){    //special case for empty queue
             head = nd;
             tail = nd;
         }else{
          Node temp = tail;   // add new Node at the tail  !
          temp.next = nd;
          tail = nd;
         }
     }

    /**
     * remove/pop element from the start of the queue
     * @return  int
     */
     public  int dequeue(){
        Node ond = head;
        if (ond == null) throw new IllegalStateException("Cannot dequeue from an empty queue");
        head = ond.next;
        if(head == null) {   // only 1 element was present
            // no more items left , the queuue is empty now
            // so nullify tail
            tail = null;
        }
        return ond.item;
    }
    /**
     * check if queue is empty
     */
     public boolean isEmpty(){
         return (head == null );
     }

    public void traversePrintQueue(){
        Node ce = head;
        int count = 0;
        System.out.println("queue: ");
        
        while(true){
           if (ce == null) { break; }
            System.out.print("{"+ ce.item + "} ");
            ce = ce.next;
        }
        System.out.println();
     }

}// end of class QueueOfInts

class QueueOfIntsTester{

    static void testQueue(){
        QueueOfInts q = new QueueOfInts();
        //fill with data
        for(int j = 0; j < 5; j++){
            q.enqueue(j);
        }
        //print queue
        q.traversePrintQueue();
        System.out.println("get first element: " + q.dequeue());
        //print queue again
        q.traversePrintQueue();

        System.out.println("get next element: " + q.dequeue());
        //print queue again
        q.traversePrintQueue();


    }


    public static void main(String[] args) {
        testQueue();
    }

    

}