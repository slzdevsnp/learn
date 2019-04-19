package org.szi.lng.typesArrays;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/19/2012
 * Time: 3:41 PM
 * To change this template use File | Settings | File Templates.
 */
public class Arrays {

    static void arrayDeclaration(){
        String[] args;      // single-dimensional array of String objects
        int[] numbers;      // single-dimensional array of ints
        byte[] buffer;      // single-dimensional array of bytes
        short[][] shorts;   // double-dimensional array of shorts

        //arrays are declared but not yet initialized
        numbers = new int[]{3, 4, 5, 7}; // using operator new
        int[] values = {10,11,12};  //compbine declation and initialization

        System.out.println("numbers arr length " + numbers.length);
    }
     static void arrayInitialization(){
         int[] myNums = { 1, 3, 5, 7, 9 };   // 5 elements
         char[] name = new char[3];
         name[0] = 'T';
         name[1] = 'o';
         name[2] = 'm';
         short[][] matrix = { {1,4,7}, {5,6,3}, {2,8,9} };
         byte[][] bufs = new byte[10][1024];

         String[] strs = {"mama", "papa", "baby"};

         //accessing elements
         System.out.println("0th el from name: " + name[0]);
         System.out.println("1th el from myNums " + myNums[1]);
         System.out.println("top left el from matrix " + matrix[0][0]);
         System.out.println("top left el from bufs " + bufs[0][0]);
         System.out.println("first el from strs " + strs[0]);
     }

    static void growArraySize(){
        int[] values = {5, 4, 3, 2, 1}; // A 5-element int array
        int[] newValues = new int[10];  // A 10-element int array

        // Copy all elements from values to newValues
        System.arraycopy(values, 0, newValues, 0, values.length);

        //assign new element
        newValues[5] = -1;
        for (int i=0;i<newValues.length;i++){
            System.out.println("newvalue el:"+newValues[i]);
        }
        // Assign the array back to values , now lenght of values array is 10
        values = newValues;
        for (int i=0;i<values.length;i++){
            System.out.println(" reassigned value el:"+values[i]);
        }
    }

    public static void main(String[] args) {
        arrayDeclaration();
        arrayInitialization();
        growArraySize();
    }
}
