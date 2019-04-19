package org.szi.lng.flowControl;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/20/2012
 * Time: 6:29 PM
 * To change this template use File | Settings | File Templates.
 */
public class NestedLoopLabel {


    static void searchForNumber2D(){
        int[][] nums = { {1, 3, 7, 5},
                {5, 8, 4, 6},
                {7, 4, 2, 9} };
        int search = 4;
        int niter = 0;

        foundNumber:   // this is label
        for ( int i=0; i < nums.length; i++){
            for (int j=0;j < nums[i].length;j++){
                niter++;
                if ( nums[i][j] == search){
                    System.out.println("Found " + search + " at position " +i +","+j );
                    break foundNumber;  //on first occurency we break out of two loops
                }
            }
        }
        System.out.println("number of loop interations in search: "+niter);
    }
    public static void main(String[] args) {
          searchForNumber2D();
    }
}
