package org.szi.lng.OOP;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/20/2012
 * Time: 7:32 PM
 * To change this template use File | Settings | File Templates.
 */

public class EmployeeDemo {

    static void showEmployees(){
        final Employee e1 = new Employee("John", "555-12-345");
        e1.setEmailAddress("john@company.com");

        final Employee e2 = new Employee("56-78-901", 1974 );
        e2.setName("Tom");

        System.out.println("employe1: " + e1.toString());
        System.out.println("employe2: " + e2.toString());

        Employee.setBaseVacationDays(20);
        System.out.println("after change of vacation policy");

        System.out.println("employe1: " + e1.toString());
        System.out.println("employe2: " + e2.toString());

        //e2 = e1; // compilation error becasue e1 and e2 are final
        Employee e3 = e1;  //e3 just like e1 point to the same object in memory
        e3  = null;
        //System.out.println("employe3 aft null: " + e3.toString());  // produces null pointer exception


    }
    static void showDerivedObject(){
        // instantiating a derived class
        final Manager m1 = new Manager("Jack", "89-66-999", "Development");
        System.out.println("manager1: " + m1.toString("BIG BOSS"));

    }
    static void showDownCasting(){
        Employee em = new Manager("Bob", "45-61-989", "Development");
        if (em instanceof Manager){
            Manager m = (Manager) em;   //downcasting
            m.setResponsibility("Operations");
            System.out.println("manager2: " + m.toString("LITTLE BOSS"));
        }
    }

    public static void main(String[] args) {
           showEmployees();
           showDerivedObject();
           showDownCasting();
    }
}
