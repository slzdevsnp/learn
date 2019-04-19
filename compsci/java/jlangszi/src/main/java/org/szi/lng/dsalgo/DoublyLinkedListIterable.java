package org.szi.lng.dsalgo;

import java.util.ListIterator;
import java.util.NoSuchElementException;


/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/27/2012
 * Time: 7:47 AM
 * To change this template use File | Settings | File Templates.
 *  @ author http://techyrajeev.blogspot.ch/2012/03/generic-doubly-linked-list-in-java.html
 * should be debug a little bit
 */

public class DoublyLinkedListIterable<Item> implements Iterable<Item> {
    private int N;        // number of elements on list
    private Node pre;     // sentinel before first item
    private Node post;    // sentinel after last item

    public DoublyLinkedListIterable() {
        pre  = new Node();
        post = new Node();
        pre.next = post;
        post.prev = pre;
    }

    // linked list node helper data type
    private class Node {          //inner class
        private Item item;
        private Node next;
        private Node prev;
    }

    public boolean isEmpty()    { return N == 0; }
    public int size()           { return N;      }

    // add the item to the list
    public void add(Item item) {
        Node last = post.prev;
        Node x = new Node();
        x.item = item;
        x.next = post;
        x.prev = last;
        post.prev = x;
        last.next = x;
        N++;
    }

    public ListIterator<Item> iterator()  { return new DoublyLinkedListIterator(); }

    // assumes no calls to DoublyLinkedListIterable.add() during iteration
    private class DoublyLinkedListIterator implements ListIterator<Item> {   //inner class
        private Node current      = pre.next;  // the node that is returned by next()
        private Node lastAccessed = null;      // the last node to be returned by prev() or next()
        // reset to null upon intervening remove() or add()
        private int index = 0;

        public boolean hasNext()      { return index < N; }
        public boolean hasPrevious()  { return index > 0; }
        public int previousIndex()    { return index - 1; }
        public int nextIndex()        { return index;     }

        public Item next() {
            if (!hasNext()) throw new NoSuchElementException();
            lastAccessed = current;
            Item item = current.item;
            current = current.next;
            index++;
            return item;
        }

        public Item previous() {
            if (!hasPrevious()) throw new NoSuchElementException();
            current = current.prev;
            index--;
            lastAccessed = current;
            return current.item;
        }

        // replace the item of the element that was last accessed by next() or previous()
        // condition: no calls to remove() or add() after last call to next() or previous()
        public void set(Item item) {
            if (lastAccessed == null) throw new IllegalStateException();
            lastAccessed.item = item;
        }

        // remove the element that was last accessed by next() or previous()
        // condition: no calls to remove() or add() after last call to next() or previous()
        public void remove() {
            if (lastAccessed == null) throw new IllegalStateException();
            Node x = lastAccessed.prev;
            Node y = lastAccessed.next;
            x.next = y;
            y.prev = x;
            N--;
            index--;
            lastAccessed = null;
        }

        // add element to list
        public void add(Item item) {
            Node x = current.prev;
            Node y = new Node();
            Node z = current;
            y.item = item;
            x.next = y;
            y.next = z;
            z.prev = y;
            y.prev = x;
            N++;
            index++;
            lastAccessed = null;
        }

    }


    static void testDoublyList(){
        //int N  = Integer.parseInt(args[0]);
        int N = 10;
        // add elements 1, ..., N
        DoublyLinkedListIterable<Integer> list = new DoublyLinkedListIterable<Integer>();
        for (int i = 0; i < N; i++)
            list.add((int) (100 * Math.random()));

        // try out the iterator
        System.out.println("after creation");
        for (Integer x : list)
            System.out.print(x + " ");
        System.out.println();

        ListIterator<Integer> iterator = list.iterator();

        // go forwards
        System.out.println("increment each elment by 1");
        while (iterator.hasNext()) {
            int x = iterator.next();
            iterator.set(x + 1);
        }

        // print contents of list
        for (Integer x : list)
            System.out.print(x + " ");
        System.out.println();

        // go backwards
        System.out.println("traverse backwards, multiply each element by 3");
        while (iterator.hasPrevious()) {
            int x = iterator.previous();
            iterator.set(3*x);
        }

        // print contents of list
        for (Integer x : list)
            System.out.print(x + " ");
        System.out.println();

        // remove all even elements
        while (iterator.hasNext()) {
            int x = iterator.next();
            if (x % 2 == 0) iterator.remove();
        }
        System.out.println("after removing all even elements");
        // print contents of list
        for (Integer x : list)
            System.out.print(x + " ");
        System.out.println();

    }


    // a test client
    public static void main(String[] args) {
         testDoublyList();
    }
}