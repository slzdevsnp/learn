package org.szi.lng.java8.lambdas;

public class FunctionalInterfaceExample {


    interface NumericTest {
        boolean computeTest(int n);
    }

    interface NumericOperation<T> {
        T compute(T a, T b);
    }

    interface MyGreeting {
        String processName(String str);
    }

    interface MyString{
        String myStringFunc(String s);
    }

    //generic interface
    interface MyGeneric<T>{
        T compute(T t);
    }


    public static void main(String args[]){
        NumericTest isEven = (n) -> (n % 2) ==  0; // lambda function def

        NumericTest isNegative = (n) -> ( n < 0);

        System.out.println("isEven:" + isEven.computeTest(10));
        System.out.println("isEven:" + isEven.computeTest(1));
        System.out.println("isNegative:" + isNegative.computeTest(-2));


        MyGreeting morningGreeting = (s) -> "Good morning " + s + "!";
        MyGreeting eveningGreeting = (s) -> "Good evening " + s + "!";

        System.out.println(morningGreeting.processName("mama"));
        System.out.println(eveningGreeting.processName("papa"));

        //block lambda expression  funcs expected to be short and self explanatory
        MyString reverseStr = (str) -> {
            String res = "";
            for(int i = str.length()-1;i>=0;i--){
                res += str.charAt(i);
            }
            return res;
        };

        String input = "mama ela kashu";
        System.out.println(input);
        System.out.println(reverseStr.myStringFunc(input));

        //generic interface integer version
        MyGeneric<Integer> factorial = (Integer n) -> {
          int res = 1;
          for(int i=1; i<=n;i++) { res = i * res;}
          return res;
        };

        System.out.println("factorial of "+5+": " + factorial.compute(5));

        //lambdas often pass as function args
        System.out.println("lambda as func arg:..");
        System.out.println(naoborotString(reverseStr,"Lambda Demo"));

        //lambdas with  2 params
        System.out.println("lambda with 2 params");
        NumericOperation<Integer> intAdd = (a, b) -> a + b;
        NumericOperation<Integer> intDivise = (a, b) -> a / b;

        System.out.println("int addition: "+ intOperate(intAdd, 9,2));
        System.out.println("int devision: "+ intOperate(intDivise, 9,2));

    }

    private static String naoborotString(MyString l, String s){
        return l.myStringFunc(s);
    }

    private  static int intOperate(NumericOperation<Integer> op, int a, int b){
        return op.compute(a,b);
    }
}

