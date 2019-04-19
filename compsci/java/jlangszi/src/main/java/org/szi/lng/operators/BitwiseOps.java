package org.szi.lng.operators;

//import com.sun.tools.corba.se.idl.constExpr.ShiftRight;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/19/2012
 * Time: 5:38 PM
 * To change this template use File | Settings | File Templates.
 */
public class BitwiseOps {

   static void simpleBitwise(){
        int x = 71;
        int y = 5;

        System.out.println("x: "+ x + " " + Integer.toBinaryString(x));
        System.out.println("y: "+ y + " " + Integer.toBinaryString(y));
        System.out.println("~x: "+ ~x + " " + Integer.toBinaryString(~x));
        System.out.println("x&y: "+ (x & y) + " " + Integer.toBinaryString(x & y));
        System.out.println("x|y: "+ (x | y) + " " + Integer.toBinaryString(x | y));
        System.out.println("x^y: "+ (x ^ y) + " " + Integer.toBinaryString(x ^ y));
        System.out.println("x>>y: "+ (x >> y) + " " + Integer.toBinaryString(x >> y));
       System.out.println("x<<y: "+ (x << y) + " " + Integer.toBinaryString(x << y));

   }


    public static void main(String[] args) {
           simpleBitwise();
    }
}
