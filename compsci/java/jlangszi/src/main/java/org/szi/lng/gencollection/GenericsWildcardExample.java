package org.szi.lng.gencollection;
 import java.util.*;
/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/24/2012
 * Time: 8:49 PM
 * To change this template use File | Settings | File Templates.
 */
public class GenericsWildcardExample {

    static void showGenericsWildCard(){
        // Create a List of Dog objects
        List<Dog> kennel = new ArrayList<Dog>();

        // Adding a Dog is no problem
        kennel.add( new Dog() );
        kennel.add( new Dog() );

        //kennel.add( new Cat() );  //makes compile error

        // The following line compiles without error
        List<?> objs = kennel;

        /*
         * But now we can't make any assumptions about the type of
         * objects in the objs List. In fact, the only thing that
         * we can safely do with them is treat them as Objects.
         * For example, implicitly invoking toString() on them.
         */

        for (Object o: objs) {
            System.out.println("String representation: " + o);
        }
    }

    static void showGenericsWildCard2(){
        // Create a List of Dog objects
        List<Dog> kennel = new ArrayList<Dog>();

        // Adding a Dog is no problem
        kennel.add( new Dog() );
        kennel.add( new Dog() );

        /*
        * We can assign to objs a reference to any List as long
        * as it contains objects of type Animal or some subclass
        * of Animal.
        */

        List<? extends Animal> objs = kennel;
        /*
        * Now we know that the objects in the objs List are
        * all Animals or all the same subclass of Animal. So
        * we can safely access the existing objects as Animals.
        * For example, invoking identify() on them.
        */
        System.out.println("showGenericsWildCard2");
        for (Animal o: objs) {
            o.identify();
        }
        /*
        * However, it would be a compilation error to try to
        * add new objects to the list through objs. We don't know
        * what type of objects the List contains. They might be
        * all Dogs, or all Cats, or all "generic" Animals.
        */
    }

    public static <T> void add1( T obj, Collection<? super T> c) {
        c.add(obj);
    }

    public static <U, T extends U> void add2( T obj, Collection<U> c) {   //natural syntax for derived classes
        c.add(obj);
    }

    static void showGenericsWildCard3(){

        //create a list of cat and doc objecgts
        List<Animal> menagerie = new ArrayList<Animal>();  //this words to combine derived objects
        menagerie.add( new Cat() );
        menagerie.add( new Dog() );
        menagerie.add( new Mouse());
        // And now let's try using our generic methods to add objects
        add1(new Dog(), menagerie);
        add2( new Cat(), menagerie);
        System.out.println("showGenericsWildCard3");
        for (Animal o: menagerie) {
            o.identify();
        }

    }

    public static void main( String[] args) {

          showGenericsWildCard();
          showGenericsWildCard2();
          showGenericsWildCard3();
    }
}
