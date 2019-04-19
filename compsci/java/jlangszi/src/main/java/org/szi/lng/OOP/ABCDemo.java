package org.szi.lng.OOP;

import org.szi.lng.ofobj.Parent;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/21/2012
 * Time: 9:01 PM
 * To change this template use File | Settings | File Templates.
 */

class A {
    String a = null;
    void doA() {
        System.out.println("A says " + a);
    }
}
class B extends A {
    String b = null;

    void doA(){    //overriding method
        System.out.println("B says its Aish value:" + a);
    }
    void doB() {
        System.out.println("B says " + b);
    }
}
class C extends B {
    String c = null;
    void doA() {
        System.out.println("Who cares what A says");
    }
    void doB() {
        System.out.println("Who cares what B says");
    }
    void doC() {
        System.out.println("C says " + a + " " + b + " " + c);
    }

}
public class ABCDemo {
    public static void main(String[] args) {
        A a = new A();
        B b = new B();
        C c = new C();

        a.a = "AAA";
        b.a = "B's A";
        b.b = "BBB";

        c.a = "C's a";
        c.b = "C's b";
        c.c = "C's c";

        System.out.println("calling A.doA, C.doA, C.doB, C all three");
        a.doA();

        b.doA();
        b.doB();

        c.doA();
        c.doB();
        c.doC();

        System.out.println("methods after upcasting");
        A ab = new B();
        ab.a = "abs A";
        ab.doA(); //version of doA() defined in B is called

    }
}
