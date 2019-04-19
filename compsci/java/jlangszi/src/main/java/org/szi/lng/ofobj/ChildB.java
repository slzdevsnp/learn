package org.szi.lng.ofobj;

public class ChildB extends Parent implements Printable{
      protected String  bString = null;
      
      //constructor
      ChildB(String n, String bstr){
    	  name = n;
    	  bString = bstr;
      }
      
      public String toString(){
    	  StringBuffer sb = new StringBuffer();
    	  sb.append("Obj B: name is "+name
    			  +" bProp: is "+ bString  );
    	  return sb.toString();		    			   
      }
}
