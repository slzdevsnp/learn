package org.szi.lng.IO;
import java.io.ObjectOutputStream;
import java.io.IOException;
import java.io.FileOutputStream;
import java.io.FileInputStream;
import java.io.ObjectInputStream;

import  org.szi.lng.OOP.Employee;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/24/2012
 * Time: 1:25 PM
 * To change this template use File | Settings | File Templates.
 */
public class SerializeEmployeeDemo {


static void storeEmployee(Employee e, String fname) throws IOException{
    ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(fname));
    try{
       oos.writeObject(e);
    }finally{
        oos.close();
    }
}

static Employee loadEmployee(String fname)  throws IOException, ClassNotFoundException{
   ObjectInputStream ois = new ObjectInputStream( new FileInputStream(fname));
    Employee e = null;
    try{
        e = (Employee) ois.readObject();
    }finally{
        ois.close();
    }
    return e;
}

    static void testSerializeEmployee()  throws IOException, ClassNotFoundException {
        Employee  fe = new Employee("John", "34-56-789", "john@my.com");
        fe.setYearOfBirth(1950);

        String fname="/tmp/employee.bin";
        storeEmployee(fe,fname); // serialize

        //deserialize
        Employee  de = loadEmployee(fname);
        System.out.println("deserialized employee: " + de.toString());
    }

    public static void main(String[] args)  throws IOException, ClassNotFoundException {
            testSerializeEmployee();
    }






}
