package org.szi.lng.patterns;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/25/2012
 * Time: 1:45 PM
 * To change this template use File | Settings | File Templates.
 */
class MySingleton {

    private static final MySingleton instance = new MySingleton();  //single instance of this class

    public static MySingleton getInstance() {      //static method to get innstance of singleton
        return instance;
    }

    private MySingleton() {} // no client can do: new MySingleton()

    public void doX(){};
    public void doY(){};
    public String getA() {return "a";}
    public int getB() {return 0;}

}

class  SingletonTester{
   public static void main(String[]args){

        MySingleton msa = MySingleton.getInstance();
        MySingleton msb = MySingleton.getInstance();
       System.out.println("msa == msb " + msa.equals(msb));
       System.out.println("singleton A property: " + msa.getA());
   }
}
