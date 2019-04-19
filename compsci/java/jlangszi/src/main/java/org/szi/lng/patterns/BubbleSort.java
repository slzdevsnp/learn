package org.szi.lng.patterns;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/26/2012
 * Time: 10:16 AM
 * To change this template use File | Settings | File Templates.
 */


public class BubbleSort implements SortInterface {
    public void sort(double[] list) {
        double temp;
        for(int i = 0; i < list.length; i++) {
            for(int j = 0; j < list.length - i; j++) {
                if(list[i] < list[j]) {
                    temp = list[i];
                    list[i] = list[j];
                    list[j] = temp;
                }
            }
        }
    }
}