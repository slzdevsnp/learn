package org.szi.lng.exceptions;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/24/2012
 * Time: 10:44 AM
 * To change this template use File | Settings | File Templates.
 */
public class DivisionExceptionDemoB {

    private static void divideSafely(String[] array) {
        try {
            System.out.println(divideArray(array));
        } catch (ArrayIndexOutOfBoundsException e) {
            System.err.println("Usage: ExceptionDemo <num1> <num2>");
        }
    }

    private static int divideArray(String[] array) {
        String s1 = array[0];
        String s2 = array[1];
        return divideStrings(s1, s2);
    }

    private static int divideStrings(String s1, String s2) {
        try {
            int i1 = Integer.parseInt(s1);
            int i2 = Integer.parseInt(s2);
            return divideInts(i1, i2);
        } catch (NumberFormatException e) {
            System.out.println(e.toString() + "division expects integers as parameters");
            return 0;
        }
    }

    private static int divideInts(int i1, int i2) {
        try {
            return i1 / i2;
        } catch (ArithmeticException e) {
            System.out.println(e.toString() + " Cannot divide by zero");
            return 0;
        }
    }

    static void testCleanCheckedDivision(String[] args){
        System.out.println("testing clean checked division");
        String[] args1 = { "100", "4"};
        divideSafely(args1);
        String[] args2 = {"100", "0"};
        divideSafely(args2);  //execution stops here as an exception is thrown
        String[] args3 = {"100", "four"};
        divideSafely(args3);
        String[] args4 = {"100"};
        divideSafely(args4);
    }



    public static void main(String[] args) {
        testCleanCheckedDivision(args);
    }


}
