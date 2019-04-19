package org.szi.lng.flowControl;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/21/2012
 * Time: 11:41 AM
 * To change this template use File | Settings | File Templates.
 */
public class RecursiveFunction {


    static int factorial(int num){
        if (num == 1){
            return 1;
        }else{
            return ( num * factorial(num-1));
        }
    }

    static void printNumSequence(int num, int nom){
        System.out.println(nom - num);
        if (num== 0){
          return;
        }else{
            printNumSequence(num-1,nom);
        }
    }

    public static void main(String[] args) {
        int input = 5;
        int f = factorial(input);
        System.out.println("factorial of " + input + " : " + f);

        printNumSequence(5,5);
    }
}
