package org.szi.lng.exceptions;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/24/2012
 * Time: 11:08 AM
 * To change this template use File | Settings | File Templates.
 */
public class CircleThrowsException {

    private final double radius;
    /**
     * Constructor.
     * @param radius the radius of the circle.
     * @throws IllegalArgumentException if radius is negative.
     */
    public CircleThrowsException(double radius){
        if (radius < 0){
            throw new IllegalArgumentException("Radius " + radius  + " expected to be positive" ) ;
        }
        this.radius = radius;
    }
}
