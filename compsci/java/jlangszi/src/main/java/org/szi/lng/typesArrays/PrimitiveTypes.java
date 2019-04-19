package org.szi.lng.typesArrays;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/19/2012
 * Time: 3:22 PM
 * To change this template use File | Settings | File Templates.
 */
public class PrimitiveTypes {

    static void primitiveDeclarations(){
        //8 primitive types
        boolean bln = true; // booleans can only be 'true' or 'false'
        byte b = 0x20;      // using hexadecimal notation
        short s = 500;      // small integer
        char c = 'A';       // must use single quotes to denote characters
        char tab = '\t';    // other specials: \n, \r, \f, \b, \\, \', \"
        int i = 1000000;    // decimal notation
        int j = 0x3FA0B3;   // hexadecimal notation
        int k = 0777;       // octal notation
        float f = 1.5f;     // trailing 'f' distinguishes from double
        long l = 2000000L;  // trailing 'L' distinguishes from int
        double pi = 3.141592653589793;  // doubles are higher precision
        double large = 1.3e100;     // using the exponent notation

    }

     static void  upDownPrimitiveConversions(){
         int i = 'A' ;  // downcasting is automatic
         byte b = 0x20;
         float m = b;
         int j = (int) 123.456; //upcasting is manual (when there is a loss of precision )
     }

    static void parseString(){

        //int myint = "6"; // will not compile
        int myint = Integer.parseInt("6"); //parsing object String

        String s = "my string";
        int len = s.length();

        boolean bul = Boolean.valueOf(s).booleanValue();
        s = "127";
        byte b = Byte.parseByte(s);  // s="128" will produce an exception
        short ss = Short.parseShort(s);
        s = "word";
        char c = s.charAt(0);
        s = "10";
        int i = Integer.parseInt(s);
        float f = Float.parseFloat(s);
        long l = Long.parseLong(s);
        double d = Double.parseDouble(s);

        System.out.println("parsed boolean " + bul);
        System.out.println("parsed  byte " + b);
        System.out.println("parsed char" + c);
        System.out.println("parsed float " + f);

    }

    static void assignprimitives(){

        int a;
        int b;
        Integer ao, bo;
        a = b = 10;     //assign both
        ao = bo = new Integer(10);
        //ao = ( bo = new Integer(10));   yields same result

        System.out.println("a: " + a);
        System.out.println("b: " + b);

        System.out.println("ao: " + ao + " bo: " + bo);

    }

    public static void main(String[] args) {

        primitiveDeclarations();
        upDownPrimitiveConversions();
        parseString();
        assignprimitives();

    }

}
