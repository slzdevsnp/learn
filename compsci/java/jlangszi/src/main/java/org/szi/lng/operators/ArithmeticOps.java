package org.szi.lng.operators;
import java.util.Date;
/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/19/2012
 * Time: 4:59 PM
 * To change this template use File | Settings | File Templates.
 */
public class ArithmeticOps {


    static void unaryCasting(){
        short a = 1;
        short b = 2;
       // short c = a + b;  //will not compile
        short c = (short) (a + b); // explicit casting to short
    }

     static void zeroDivision(){

         float res = (float) (1.0/0.0);
         System.out.println("float zero div " + res);

        /*
         int ires = 1/0;   // produces Arithmetic Exception / by zero
         System.out.println("int zero div " + ires);
        */
     }

    static void incrShortCuts(){
        int x1 = 2;
        int x2 = 2;
        int y1 = x1++;  //assign to y1 initial x1 than increment it
        int y2 = ++x2;  //increment x2 than assign its updated value to y2
        System.out.println("shortcuted y1 " + y1);
        System.out.println("shortcuted y2 " + y2);
        System.out.println("x1 " + x1);
        System.out.println("x2 " + x2);
    }
     static void stringConcatenationPrecedence(){
         //left to write precedence
         String test1 = 1 + 1 + " equals " + 1 + 1;   // "2 equals 11"
         String test2 = (1 + 1) + " equals " + (1 + 1);   // "2 equals 2"
         System.out.println("concatenated string1: " + test1);
         System.out.println("concatenated string2: " + test2);
     }
    static void toStringAutoConversion(){
        Date now = new Date();
        String msg = "The time is: " + now;
        System.out.println(msg);
    }
    public static void main(String[] args) {
         unaryCasting();
         zeroDivision();
         incrShortCuts();
         stringConcatenationPrecedence();
        toStringAutoConversion();
    }

}
