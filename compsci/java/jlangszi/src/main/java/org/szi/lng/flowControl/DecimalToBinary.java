package org.szi.lng.flowControl;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/21/2012
 * Time: 11:54 AM
 * To change this template use File | Settings | File Templates.
 */
public class DecimalToBinary {


    static String decimalToBinaryStr(int num, int length){

        int[] binary = new int[length];
        //initialize
        for (int i=0 ; i<length;i++){
            binary[i] = 0;
        }

        int j = 0;
        while(num != 0){
            int rem = num % 2;
            binary[length-1-j] = rem;
            num = num / 2;
            j++;
        }
        StringBuffer sb = new StringBuffer();
        for (int i=0 ; i<length;i++){
            sb.append( binary[i] );
        }
        return( sb.toString());

    }

    public static void main(String[] args) {
        int rlength = 32;
        System.out.println("5 in binary: " + decimalToBinaryStr(5, rlength));
        System.out.println("71 in binary: " + decimalToBinaryStr(71, rlength));

    }
}
