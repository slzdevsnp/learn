package org.szi.lng.patterns;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/26/2012
 * Time: 10:21 AM
 * To change this template use File | Settings | File Templates.
 */

//The context maintains a reference to a Strategy object and forwards client requests to the strategy.
// Context may also define an interface to let Strategies access context data.

public class SortingContext{

    private SortInterface sorter = null;

    public void sortDouble(double[] list) {
        sorter.sort(list);
    }

    public SortInterface getSorter() {
        return sorter;
    }

    public void setSorter(SortInterface sorter) {
        this.sorter = sorter;
    }

}
