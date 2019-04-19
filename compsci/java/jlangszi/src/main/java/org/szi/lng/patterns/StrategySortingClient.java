package org.szi.lng.patterns;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/26/2012
 * Time: 10:23 AM
 * To change this template use File | Settings | File Templates.
 */
public class StrategySortingClient {

    static void testSortingStrategyBubble(double[] data){
        SortingContext context = new SortingContext();
        context.setSorter(new BubbleSort());   // a concrete Strategy is chosen
        context.sortDouble(data);  //call of concrete strategy
        System.out.println("sorted with bubble");
        for(int i =0; i< data.length; i++) {
            System.out.println(data[i]);
        }
    }
    static void testSortingStrategyQuicksort(double[] data){
        SortingContext context = new SortingContext();
        context.setSorter(new QuickSort());   // a concrete Strategy is chosen
        context.sortDouble(data);  //call of concrete strategy
        System.out.println("sorted with quicksort");
        for(int i =0; i< data.length; i++) {
            System.out.println(data[i]);
        }
    }

    public static void main(String[] args) {
        double[] list = {1,2.4,7.9,3.2,1.2,0.2,10.2,22.5,19.6,14,12,16,17};
        testSortingStrategyBubble(list);
        testSortingStrategyQuicksort(list);

    }
}
