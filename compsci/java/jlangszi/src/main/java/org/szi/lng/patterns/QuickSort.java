package org.szi.lng.patterns;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/26/2012
 * Time: 10:04 AM
 * To change this template use File | Settings | File Templates.
 */


public class QuickSort  implements  SortInterface{      //concrete sorting strategy

    public void sort(double[] a){
        quicksort(a, 0, a.length -1 );
    }
     private void quicksort(double[] a, int left, int right){
         if (right <= left)  { return ; } // finished sorting
         int i = partition(a, left, right);
         quicksort(a, left, i-1);   //recursive calls
         quicksort(a, i+1, right);
     }
    private int partition(double[] a, int left, int right) {
        int i = left;
        int j = right;
        while (true) {
            while (a[i]< a[right]) { i++;}
            while (less(a[right], a[--j])) { if (j == left) break; }
            if (i >= j) break;
            exch(a, i, j);
        }
        exch(a, i, right);
        return i;
    }

    private boolean less(double x, double y) {
        return (x < y);
    }

    private void exch(double[] a, int i, int j) {
        double swap = a[i];
        a[i] = a[j];
        a[j] = swap;
    }

}

