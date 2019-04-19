package org.szi.lng.OOP;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/22/2012
 * Time: 6:44 AM
 * To change this template use File | Settings | File Templates.
 */
public class Manager extends Employee{
    private String responsibility; // field specific to derived class

    public Manager(String name, String ssn, String responsibility){
        super(name,ssn);  // call constructor from a base class
        this.responsibility=responsibility;
    }

    public void setResponsibility(String responsibility){
        this.responsibility = responsibility;
    }
    public String getResponsibility(){
        return ( this.responsibility);
    }

    public String toString(String header){
       String out = super.toString(header);
       out += "Responsibility: " + this.responsibility ;
       return (out);
    }
}
