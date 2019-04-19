package org.szi.lng.OOP;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/22/2012
 * Time: 12:23 PM
 * To change this template use File | Settings | File Templates.
 */


class Box{
     private double side;

     Box(double side){
         this.side = side;
     }
     @Override
     public boolean equals(Object obj){
         if (obj == this){
             //compare to ourself
             return true;
         }
         else if(obj == null || obj.getClass() != this.getClass()){
             //should compare only to another Box object
             return false;
         }else{
             Box b = (Box) obj;
             return b.side == this.side;
         }
     }
 }

// more complex class with more logic in equals()
class Person {
    private String name;
    private final int yearOfBirth;
    private String emailAddress;

    public Person(String name, int yearOfBirth) {
        this.name = name;
        this.yearOfBirth = yearOfBirth;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getYearOfBirth() {
        return this.yearOfBirth;
    }

    public String getEmailAddress() {
        return this.emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }
    @Override
    public boolean equals(Object o) {
        if (o == this) {
            // we are being compared to ourself
            return true;
        } else if (o == null || o.getClass() != this.getClass()) {
            // can only compare to another person
            return false;
        } else {
            Person p = (Person) o; // cast to our type
            // compare significant fields
            return p.name.equals(this.name) &&
                    p.yearOfBirth == this.yearOfBirth;  //no check on email field
        }
    }
    //maast be overwritten  because equals() is overwritten
    public int hashCode() {
        // compute based on significant fields
        return 3 * this.name.hashCode() + 5 * this.yearOfBirth;
    }
}


public class EqualityDemo {

    static void checkBoxEquality(){
        Box b1 = new Box(1);
        Box b2 = new Box(2);
        Box b3 = new Box(1);
        System.out.println("b1 is b1 ? " + b1.equals(b1));
        System.out.println("b1 is b2 ? " + b1.equals(b2));
        System.out.println("b1 is b3 ? " + b1.equals(b3));
    }

    static void checkPersonEquality(){
        Person p1 = new Person("John", 1951);
        p1.setEmailAddress("jh@my.com");
        Person p2 = new Person("Mary", 1951);
        Person p3 = new Person("John", 1951);
        p3.setEmailAddress("jj@gmail.com");

        System.out.println("p1 is p2 ? " + p1.equals(p2));
        System.out.println("p1 is p3 ? " + p1.equals(p3));
    }


    public static void main(String[] args) {
         checkBoxEquality();
         checkPersonEquality();
    }
}
