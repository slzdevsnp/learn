package org.szi.lng.typesArrays;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/27/2012
 * Time: 1:23 PM
 * To change this template use File | Settings | File Templates.
 */
public class AssertTest {

    public static void main(String[] args) {

        //call java -ea  org.szi.lng.typesArrays.AssertTest    // asserts are for debugs
        int number = -20;
        assert ( number >=0 && number <= 10 ) :  "bad expected value for i: " + number;
        System.out.println("i value : " + number);
    }
}
