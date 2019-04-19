package org.szi.lng.typesArrays;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/26/2012
 * Time: 1:12 PM
 * To change this template use File | Settings | File Templates.
 */
public class Recursion {


    static long factorial(long n){
        if (n == 1) { return 1;}
        else{
            return n * factorial(n-1);
        }
    }


    static void printSequenceRecursivelely(int n, int limit){
        if( n == 0){ return ; }
        else{
            System.out.println(limit - n );
            printSequenceRecursivelely(n-1, limit);
        }
    }



    public static void main(String[] args) {
        long a = 5;
        System.out.println("factorial of " + a + " : " + factorial(a));

        int n = 7;
        printSequenceRecursivelely(n,n);

    }


}
