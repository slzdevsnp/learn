package org.szi.lng.patterns;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/25/2012
 * Time: 2:33 PM
 * To change this template use File | Settings | File Templates.
 */


import java.util.Enumeration;
import java.util.Iterator;

/**
 * Adapts Enumeration interface to Iterator interface.
 * Does not support remove() operation.
 */
class EnumerationAsIterator implements Iterator {

    private final Enumeration enumeration;

    public EnumerationAsIterator(Enumeration enumeration) {
        this.enumeration = enumeration;
    }

    public boolean hasNext() {        //remimplementing methods from Iterator interface
        return this.enumeration.hasMoreElements();
    }

    public Object next() {
        return this.enumeration.nextElement();
    }

    /**
     * Not supported.
     * @throws UnsupportedOperationException if invoked
     */
    public void remove() {
        throw new UnsupportedOperationException("Cannot remove");
    }

}
