package org.szi.lng.dsalgo;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/27/2012
 * Time: 9:49 AM
 * To change this template use File | Settings | File Templates.
 */

class DLNode<T> {
    private T data;
    private DLNode<T> next;
    private DLNode<T> prev;
    DLNode(){
        next=null;
        prev=null;
        data=null;
    }
    DLNode(T data) {
        this(data, null, null);
    }
    DLNode(T data, DLNode<T> next, DLNode<T> prev) {
        this.data = data;
        this.next = next;
        this.prev = prev;
    }
    T getData() {
        return data;
    }
    public void setNextNode(DLNode<T> next) {
        this.next = next;
    }
    public DLNode<T> getPrevNode() {
        return prev;
    }
    public void setPrevNode(DLNode<T> prev) {
        this.prev = prev;
    }
    public void setData(T data) {
        this.data = data;
    }
    public DLNode<T> getNextNode() {
        return next;
    }
}
//// LinkedList class
class DoublyLinkedList<T> {
    private DLNode<T> head;
    private DLNode<T> tail;

    //Returns the no. of nodes in Doubly linked list
    public int getSize(){
        int count = 0;
        if(head==null)
            return count;
        else{
            DLNode<T> temp=head;
            do{
                temp=temp.getNextNode();
                count++;
            }while(temp!=tail);
        }
        return count;
    }

    //Traverse from head
    public void traverseF(){
        DLNode<T> temp=head;
        while(temp!=null){
            System.out.print(temp.getData()+" ");
            temp=temp.getNextNode();
        }
    }
    //Traverse from tail
    public void traverseB(){
        DLNode<T> temp=tail;
        while(temp!=null){
            System.out.print(temp.getData()+" ");
            temp=temp.getPrevNode();
        }
    }
    /* methods related to insertion in doubly linked list starts.*/
    public void insertAtBeg(T data){
        DLNode<T> newnode=new DLNode<T>(data);
        if(head==null){
            head=newnode;
            tail=newnode;
            newnode.setNextNode(null);
            newnode.setPrevNode(null);
        }else{
            newnode.setNextNode(head);
            head.setPrevNode(newnode);
            head=newnode;
        }

    }
    public void insertAtEnd(T data){
        DLNode<T> newnode=new DLNode<T>(data);
        if(tail==null){
            head=newnode;
            tail=newnode;
            newnode.setNextNode(null);
            newnode.setPrevNode(null);
        }else{
            newnode.setPrevNode(tail);
            tail.setNextNode(newnode);
            tail=newnode;
        }
    }
    public void insertAtPosition(T data,int position){
        if(position<0||position==0){
            insertAtBeg(data);
        }
        else if(position>getSize()||position==getSize()){
            insertAtEnd(data);
        }else{

            DLNode<T>temp=head;
            DLNode<T> newnode=new DLNode<T>(data);
            for(int i=0;i<position-1;i++){
                temp=temp.getNextNode();
            }

            newnode.setNextNode(temp.getNextNode());
            temp.getNextNode().setPrevNode(newnode);
            temp.setNextNode(newnode);
            newnode.setPrevNode(temp);
        }
    }
/* methods related to insertion in doubly linked list ends.*/

    /* methods related to deletion in doubly linked list starts.*/
//Removal based on a given node for internal use only
    @SuppressWarnings("unused")
    private void remove(DLNode<T> node){
        if(node.getPrevNode()==null)
            head=node.getNextNode();
        else if(node.getNextNode()==null)
            tail=node.getPrevNode();
        else{
            DLNode<T> temp=node.getPrevNode();
            temp.setNextNode(node.getNextNode());
            node.getNextNode().setPrevNode(temp);
        }
        node=null;
    }
    //Removal based on a given position
    public T remove(int position){
        T data=null;
        if(position==1){
            data=head.getData();
            head=head.getNextNode();
        }else if(position==getSize()){
            data=tail.getData();
            tail=tail.getPrevNode();
            tail.setNextNode(null);
        }else{
            DLNode<T> temp=head;
            for(int i=0;i<position;i++){
                temp=temp.getNextNode();
            }
            DLNode<T> node=temp.getNextNode();
            node.setPrevNode(temp.getPrevNode());
            temp.getPrevNode().setNextNode(node);
            temp=null;
        }
        return data;//Deleted node's data
    }
    /* methods related to deletion in doubly linked list ends.*/

}


class DoublyLinkedListTest {

     static void testDoublyList(){
         DoublyLinkedList< Integer> dll=new DoublyLinkedList<Integer>();
         dll.insertAtBeg(32);
         dll.insertAtBeg(35);
         dll.insertAtBeg(45);
         dll.insertAtEnd(12);
         dll.traverseF();
         System.out.println();
         dll.traverseB();
         System.out.println("Size is:"+dll.getSize());

         dll.insertAtPosition(46,0);
         System.out.println();

         dll.traverseF();
         System.out.println("Removed at pos 5:"+dll.remove(5));
         System.out.println("Size is:"+dll.getSize());
         dll.traverseF();
         dll.remove(1);
         System.out.println();
         dll.traverseF();
     }


    public static void main(String[] args) {
          testDoublyList();
    }
}
