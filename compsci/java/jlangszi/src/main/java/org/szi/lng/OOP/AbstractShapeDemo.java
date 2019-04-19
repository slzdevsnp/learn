package org.szi.lng.OOP;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/22/2012
 * Time: 8:55 AM
 * To change this template use File | Settings | File Templates.
 */

/**
 * Figure Shape contract
 * @author <a href="mailto:szi@me.com">szi</a>
 * @version 1.0
 */
interface Shape{   //contract
   /**
      Perform calculation of shape area
      @return area result  as double
     */
    double getArea();
    /**
     Perform calculation of shape perimeter
     @return perimeter result  as double
     */
    double getPerimeter();
    String getShapeName();
}

abstract class Triangle implements Shape{
    abstract double getA(); //A side
    abstract double getB(); //B side
    abstract double getC(); //C side
    final String shapename = "triangle";
    public double getPerimeter(){  //implemented method in abstract class
        return ( getA() + getB() + getC() );
    }
    public String getShapeName(){
        return shapename;
    }
    abstract public double getArea(); // abstract  method as it is not implemented
}

class RightAngleTriangle extends Triangle {
    private double  a,b,c;

    RightAngleTriangle(double a, double b){
        this.a = a;
        this.b = b;
        this.c = Math.sqrt( Math.pow(a,2) + Math.pow(b, 2));
    }

    double getA() {
        return a;
    }

    double getB() {
        return b;
    }

    double getC() {
        return c;
    }

    public double getArea(){
        return (a*b)/2;
    }
}

class Circle implements Shape{
    private double radius;
    private final String shapename = "circle";
    Circle(double radius){
        this.radius = radius;
    }
    double getRadius() {
        return radius;
    }
    public double getArea(){
        return(Math.PI*Math.pow(this.radius,2));
    }
    public double getPerimeter(){
        return(2*Math.PI*this.radius);
    }
    public String getShapeName(){
        return this.shapename;
    }
}
class Rectangle implements Shape{
    private double width, height;
    private final String shapename = "rectangle";
    Rectangle(double wid, double hei){
        this.width = wid;
        this.height = hei;
    }
    public double getArea(){
        return (this.width * this.height );
    }
    public double getPerimeter(){
        return (2*(this.width+this.height));
    }
    public String getShapeName(){
        return this.shapename;
    }
}
class Square extends Rectangle{
    private final String shapename = "square";
    Square(double side){
        super(side,side); //call constructor from base class
    }
}

class ShapePrinter{
    void print(Shape shape){
        System.out.println("SHAPE: " + shape.getShapeName());
        System.out.println("AREA: " + shape.getArea());
        System.out.println("PERIMETER: " + shape.getPerimeter());
    }

}


class AbstractShapeDemo {

    static void showAbstractedTriangle(){
        RightAngleTriangle rat = new RightAngleTriangle(3,4);
        System.out.println("rat Triangle C side:" + rat.getC());
        System.out.println("rat Triangle area: " + rat.getArea());

    }

    static void showInterfacePolymorphism(){
        Circle c = new Circle(5.0);
        Rectangle r = new Rectangle(3,4);
        RightAngleTriangle rat = new RightAngleTriangle(3,4);

        System.out.println("###testing interface polymorphism");

        ShapePrinter printer = new ShapePrinter();
        printer.print(c);
        printer.print(r);
        printer.print(rat);
    }


    public static void main(String[] args) {
      showAbstractedTriangle();
      showInterfacePolymorphism();
    }
}
