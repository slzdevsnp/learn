package org.szi.lng.flowControl;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/21/2012
 * Time: 6:17 PM
 * To change this template use File | Settings | File Templates.
 */
public class Vararg {

    static int max(int... values){
        int max = Integer.MIN_VALUE;
        for(int i: values){
            if (i > max) { max = i; }
        }
        return(max);
    }


    public static void main(String[] args) {
        System.out.println("max(1,-2,3,-4: " + max(1,-2,3,-4));
        int[] myvals = new int[]{5,-7,26,-13,42,365};
        System.out.println("max(myvals): " + max(myvals));
    }
}
