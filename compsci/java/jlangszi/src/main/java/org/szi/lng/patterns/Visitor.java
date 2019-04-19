package org.szi.lng.patterns;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/26/2012
 * Time: 10:44 AM
 * To change this template use File | Settings | File Templates.
 */


// contract for visitors
 interface Visitor {
    public int visit(MyInteger wheel);
    public int visit(MyLong engine);

}

interface Visitable {
    public int accept(Visitor visitor);
}

///object A
class MyInteger implements Visitable {
    private int value;

    MyInteger(int i) {
        this.value = i;
    }

    public int accept(Visitor visitor) {
        return visitor.visit(this);
    }
    public int getValue() {
        return value;
    }
}

////object B
class MyLong implements Visitable {
    private long value;

    MyLong(long l) {
        this.value = l;
    }

    public int accept(Visitor visitor) {
        return visitor.visit(this);
    }

    public long getValue() {
        return value;
    }
}
 /// class for operation on
class SubtractVisitor implements Visitor {
    int value;

    public SubtractVisitor(int value) {
        this.value = value;
    }

    public int visit(MyInteger i) {
        System.out.println("Subtract integer");
        return (i.getValue() - value);
    }

    public int visit(MyLong l) {
        System.out.println("Subtract long");
        return ((int) l.getValue() - value);
    }

}

class AddVisitor implements Visitor {
    int value;

    public AddVisitor(int value) {
        this.value = value;
    }

    public int visit(MyInteger i) {
        System.out.println("Adding integer");
        return (value + i.getValue());
    }

    public int visit(MyLong l) {
        System.out.println("Adding long");
        return (value + (int) l.getValue());
    }

}

class VisitorTest{


    static void testVisitorPattern(){
        AddVisitor cv = new AddVisitor(10);
        SubtractVisitor sv = new SubtractVisitor(10);
        MyInteger i = new MyInteger(20);
        MyLong l = new MyLong(20);
        System.out.println(i.accept(cv));
        System.out.println(l.accept(cv));

        System.out.println(i.accept(sv));
        System.out.println(l.accept(sv));

    }

    public static void main(String[] args) {
          testVisitorPattern();
    }
}


