package org.szi.lng.patterns;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/25/2012
 * Time: 1:59 PM
 * To change this template use File | Settings | File Templates.
 */

interface Dog
{
    public void speak ();
}

//concrete Dog classes
class Poodle implements Dog
{
    public void speak()
    {
        System.out.println("The poodle says \"arf\"");
    }
}

class Rottweiler implements Dog
{
    public void speak()
    {
        System.out.println("The Rottweiler says (in a very deep voice) \"WOOF!\"");
    }
}

class SiberianHusky implements Dog
{
    public void speak()
    {
        System.out.println("The husky says \"Dude, what's up?\"");
    }
}

class DogFactory
{
    public static Dog getDog(String criteria)              //static methods
    {
        if ( criteria.equals("small") )
            return new Poodle();
        else if ( criteria.equals("big") )
            return new Rottweiler();
        else if ( criteria.equals("working") )
            return new SiberianHusky();

        return null;
    }
}

class MyFactory {

    public static void main(String[] args) {

        //create a small dog
        Dog dog = DogFactory.getDog("small");
        dog.speak();

        //create a big dog
        dog = DogFactory.getDog("big");
        dog.speak();

    }
}
