package org.szi.lng.gencollection;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/24/2012
 * Time: 8:46 PM
 * To change this template use File | Settings | File Templates.
 */


abstract class Animal {
    abstract public void speak();

    public void identify() {
        System.out.println("I'm an animal.");
    }
}

class Dog extends Animal {
    @Override
    public void speak() {
        System.out.println("woof");
    }

    @Override
    public void identify() {
        System.out.println("I'm a Dog.");
    }
}

class Cat extends Animal {
    @Override
    public void speak() {
        System.out.println("meow");
    }

    @Override
    public void identify() {
        System.out.println("I'm a Cat.");
    }
}

class Mouse extends Animal {
    @Override
    public void speak() {
        System.out.println("pee");
    }

    @Override
    public void identify() {
        System.out.println("I'm a Mouse.");
    }
}


