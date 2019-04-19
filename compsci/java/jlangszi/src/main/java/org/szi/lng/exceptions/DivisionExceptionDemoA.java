package org.szi.lng.exceptions;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/24/2012
 * Time: 9:58 AM
 * To change this template use File | Settings | File Templates.
 */


class DivisionExceptionDemoA {

    private static int divideArray(String[] array){
        String s1 = array[0];
        String s2 = array[1];
        return ( divideStrings(s1, s2) );
    }




    private static int divideStrings(String s1, String s2){
        int i1 = Integer.parseInt(s1);
        int i2 = Integer.parseInt(s2);
        return ( divideInts(i1,i2));
    }



    private static int divideInts(int i1, int i2){
        return (i1 / i2);
    }


    static void printUncheckedDivision(String[] arrgs){
        String s1 = arrgs[0];
        String s2 = arrgs[1];
        System.out.println("dividing " + s1 +" by " + s2 + " : " + divideArray(arrgs));
    }
    static void printCheckedDivision(String[] arrgs){
        try{
            String s1 = arrgs[0];
            String s2 = arrgs[1];
            System.out.println("dividing " + s1 +" by " + s2 + " : " + divideArray(arrgs));
        }catch ( ArrayIndexOutOfBoundsException e){
            System.out.println(e.toString() + " Usage: ExceptionDemoA <num1> <num2>");
        }catch (NumberFormatException e){
            System.out.println(e.toString() +  " Args must me integers");
        }catch (ArithmeticException e){
            System.out.println(e.toString() + " Cannot divide by zero");
        } catch (RuntimeException e) {
        System.err.println("Error result: 0");
       }
    }

    static void testUncheckedDivision(String[] args){
        System.out.println("testing unchecked division");
        String[] args1 = { "100", "4"};
        printUncheckedDivision(args1);
        String[] args2 = {"100", "0"};
        printUncheckedDivision(args2);  //execution stops here as an exception is thrown
        String[] args3 = {"100", "four"};
        printUncheckedDivision(args3);
        String[] args4 = {"100"};
        printUncheckedDivision(args4);
    }

    static void testCheckedDivision(String[] args){
        System.out.println("testing checked division");
        String[] args1 = { "100", "4"};
        printCheckedDivision(args1);
        String[] args2 = {"100", "0"};
        printCheckedDivision(args2);  //execution stops here as an exception is thrown
        String[] args3 = {"100", "four"};
        printCheckedDivision(args3);
        String[] args4 = {"100"};
        printCheckedDivision(args4);
    }



    public static void main(String[] args) {

        testCheckedDivision(args);
        testUncheckedDivision(args);

    }
}
