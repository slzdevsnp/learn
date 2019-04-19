package org.szi.lng.operators;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/19/2012
 * Time: 5:55 PM
 * To change this template use File | Settings | File Templates.
 */
public class OtherOps {


    static void shortIf(){
        int x = 0;
        int y = 5;

       // Long way

        int z1;
        if (x == 0) {
            z1 = 0;
        } else {
            z1 = x / y;
        }

       // Short-cut way
        int z2 = (x == 0) ? 0 : x / y;
    }

    static void isInstanceOf(){
        String s = "mama";
        if (s instanceof String){
            System.out.println("s is effectively of type String");
        }
        int j = 10;
        if (new Integer(j) instanceof Integer){
            System.out.println(j + " is primitive of Integer");
        }
        //if (j instanceof int ){ } // will not compile

    }

    static void newOp(){
        String s = new String("papa");
        System.out.println("created with operator new a string: " +s);
    }


    public static void main(String[] args) {
         shortIf();
         isInstanceOf();
         newOp();
    }
}
