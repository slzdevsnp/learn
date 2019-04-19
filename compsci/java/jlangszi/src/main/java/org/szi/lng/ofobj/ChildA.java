package org.szi.lng.ofobj;

public class ChildA extends Parent implements Printable {
	
     private Integer aInteger = null;
 
     //constructor
     ChildA(String n, Integer aint){
   	  name = n;
   	  aInteger = aint;
     }
     
     public String toString(){
   	  StringBuffer sb = new StringBuffer();
   	  sb.append("Obj A: name is "+name
   			  +" aProp: is "+ aInteger.toString() );
   	  return sb.toString();		    			   
     }
}
     
