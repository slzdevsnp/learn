package org.szi.lng.dsalgo;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/26/2012
 * Time: 7:42 PM
 * To change this template use File | Settings | File Templates.
 */

class StackElement {
    public int data1;
    public StackElement nextElref;   //ref / pointer to next Link

    //StackElement constructor
    public StackElement(int d1) {
        data1 = d1;
    }

    //Print StackElement data
    public void printStack() {
        System.out.print("{" + data1 + "} ");
    }
}
////// LinkedList implementation
class Stack {
    private StackElement first;     //first element

    //Stack constructor
    public Stack() {
        first = null;
    }

    //Returns true if list is empty
    public boolean isEmpty() {
        return first == null;
    }

    //Inserts a new StackElement at the first of the list
    public void push(int d1) {
        StackElement stack = new StackElement(d1);
        stack.nextElref = first;   //existing element is pushed 1 unit furhter
        first = stack;            //current element is replaced with new object
    }


    //Deletes the StackElement at the first of the list
    public StackElement pop() {
        StackElement temp = first;
        first = first.nextElref;
        return temp;
    }

    public int getLength(){
        StackElement ce = first;
        int length = 0;
        while(true){
            if (ce == null ) { break; }
            ce = ce.nextElref;
            length++;
        }
        return length;
    }

    //get data from the indexed element
    public int get(int index)throws Exception {
        int count = 0;
        StackElement currEl = first;
        if (index == 0 ) { return first.data1 ; } //special case for head
        if (index > this.getLength()-1 ){
            System.out.println("trying to access element beyond border,. returning last element");
        }
        while( count < Math.min(index, this.getLength()-1)  && currEl != null){    //traverse only untill boundary
            count++;
            currEl  = currEl.nextElref;
            if (currEl == null ){
                throw  new Exception("Stack out of boundary exception");
            }
        }

        return (currEl.data1) ;
    }



    //Prints list data
    public void printList() {
        StackElement currentStack = first;
        System.out.print("List: ");
        while(currentStack != null) {
            currentStack.printStack();
            currentStack = currentStack.nextElref;
        }
        System.out.println("");
    }
}


class StackTest {
      static void testStack(){
          Stack list = new Stack();
          list.push(1);
          list.push(2);
          list.push(3);
          list.push(4);
          list.push(5);

          System.out.println("after insertion");
          list.printList();

          while(!list.isEmpty()) {
              StackElement deletedStack = list.pop();
              System.out.print("deleted: ");
              deletedStack.printStack();
              System.out.println("");
          }
          System.out.println("after deletetion");
          list.printList();
      }

      static void testGettingElement() throws Exception {
          Stack list = new Stack();
          list.push(1);
          list.push(2);
          list.push(3);
          list.push(4);
          list.push(5);

          list.printList();
          System.out.println("list length: " + list.getLength());
          int idx = 0;
          System.out.println("index " + idx + " data " + list.get(idx));
          idx = 1;
          System.out.println("index " + idx + " data " + list.get(idx));
          idx = 2;
          System.out.println("index " + idx + " data " + list.get(idx));
          idx = 5;
          System.out.println("index " + idx + " data " + list.get(idx));

      }

    public static void main(String[] args) throws Exception {
        testStack();
        testGettingElement();
    }
}
