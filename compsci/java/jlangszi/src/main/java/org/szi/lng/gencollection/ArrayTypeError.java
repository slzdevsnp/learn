package org.szi.lng.gencollection;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/24/2012
 * Time: 8:33 PM
 * To change this template use File | Settings | File Templates.
 */



public class ArrayTypeError {


    static void testnArrayType(){
        // Create an array of three anonymous dogs
        Dog[] kennel = { new Dog(), new Dog(), new Dog()};

        // Let them all speak
        for (Dog d: kennel) d.speak();

        // Dogs are Objects, so this should work
        Object[] things = kennel;

        /* A Cat is an Object, so we should be able to add one to the
         * things array. Note that the following does NOT cause a
         * compiler error! Instead it throws a RUNTIME exception,
         * ArrayStoreException.
         */
        //things[0] = new Cat(); //produces a runtime exeption
    }

    static void testParentType(){
        List<Animal> animals = new ArrayList<>();
        animals.add(new Dog());
        animals.add(new Cat());
        animals.add(new Mouse());
        System.out.println("in testParentType()");
        for (Animal a: animals){
            a.speak();
        }
    }

    static void testGenericsTypeError(){
        //make list of Doc objects
        List<Dog> kennel = new ArrayList<Dog>();
        kennel.add(new Dog() ); // we can add new Dog objs

        //List<Object> objs = kennel;  //results in compile error
        //otherwise objs.add( new Cat() ); will be possible
    }


    public static void main(String[] args)
    {
        testnArrayType();
        testParentType();
    }
}
