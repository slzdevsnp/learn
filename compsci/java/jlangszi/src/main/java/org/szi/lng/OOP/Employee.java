package org.szi.lng.OOP;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/20/2012
 * Time: 7:29 PM
 * To change this template use File | Settings | File Templates.
 */
public class Employee implements Serializable {

    String name;
    String ssn;
    int yearOfBirth = -1;
    String emailAddress = "undefined";
    static int baseVacationDays = 10;

    //constructors
    public Employee(String ssn){
        this.ssn=ssn;
    }
    public Employee(String name, String ssn){
        this(ssn); // call another constructor
        this.name = name;

    }

    public Employee(String name, String ssn, String emailAdress){
        this(name,ssn);
        this.emailAddress = emailAdress;
    }
    Employee(String ssn, int yob){
        this(ssn);
        this.yearOfBirth = yob;
    }
    //static method example, operates on all instances of Class
    static void setBaseVacationDays(int days){
        baseVacationDays = (days < 10) ? 10 :days ;
    }
    static int getBaseVacationDays(){
        return baseVacationDays;
    }
    public void setName(String name) {
        if(name != null && name.length() > 0){       //input validation
         this.name = name;
        }
    }

    public void setSsn(String ssn) {
        this.ssn = ssn;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    public void setYearOfBirth(int yearOfBirth) {
        this.yearOfBirth = yearOfBirth;
    }


    public String toString() {
        StringBuffer sb = new StringBuffer();
        sb.append("Name: " + this.name + "\n");
        sb.append("SSN: " + this.ssn + "\n");
        sb.append("Email: " + this.emailAddress + "\n");
        sb.append("Year of Birth: " + this.yearOfBirth + "\n");
        sb.append("Vacation days: " + Employee.baseVacationDays + "\n");
        return (sb.toString());
    }
    public String toString(String header){
        String out = header +"\n" + this.toString();
        return out;
    }
}
