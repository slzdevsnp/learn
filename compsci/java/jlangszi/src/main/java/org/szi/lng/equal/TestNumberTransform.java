package org.szi.lng.equal;

/**
 * User: szi
 * Date: 14 juin 2009
 * Time: 16:54:07
 */
public class TestNumberTransform {
    public static void main(String[] args) {

        long n1 = 200;
        double n2  = 5.57;
        double resl = n1 / n2;

        int res2 = (int)(n1 / n2);
        System.out.println("res1 " + resl);
        System.out.println("res2 " + res2);

        long m1 = 2001;
        long m2 = 20033;

        long diff = m1 - m2;


    }
}
