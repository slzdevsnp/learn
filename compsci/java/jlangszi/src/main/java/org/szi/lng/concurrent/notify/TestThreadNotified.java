package org.szi.lng.concurrent.notify;

/**
 * Created by IntelliJ IDEA.
 * User: slava
 * Date: Apr 20, 2009
 * Time: 4:55:10 PM
 * To change this template use File | Settings | File Templates.
 */
public class TestThreadNotified {

    public static void main(String[] args) {
        ThreadNotified w1 = new ThreadNotified(1);
        new Thread(w1).start();

        ThreadNotified w2 = new ThreadNotified(2);
        new Thread(w2).start();

        ThreadNotified w3 = new ThreadNotified(3);
        new Thread(w3).start();

    }
}
