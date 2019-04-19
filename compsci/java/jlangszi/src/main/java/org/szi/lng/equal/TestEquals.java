package org.szi.lng.equal;

/**
 * Created by IntelliJ IDEA.
 * User: slava
 * Date: May 13, 2009
 * Time: 5:15:47 PM
 * To change this template use File | Settings | File Templates.
 */
public class TestEquals {

    public static void main(String[] args){

        testOperatorEqual();

    }

    static void testOperatorEqual()
    {
        Integer io1 = new Integer(3);
        Integer io2;
        io2 = io1;

        if (io2 == io1) System.out.println("refs io2 and io2 are the same");

        if (io2.equals(io1)) System.out.println("object behind io2 and io2 is the same");

    }
}
