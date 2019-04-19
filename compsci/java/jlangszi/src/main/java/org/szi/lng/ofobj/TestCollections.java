/**
 * 
 */
package org.szi.lng.ofobj;

import java.util.ArrayList;
import java.util.List;
import java.util.Iterator;
import java.lang.String;
/**
 * @author zimine
 *
 */
public class TestCollections {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		//simple List
		//List<String>  l = fillStringList();
		
		/*
    	for (Iterator<String> ent = l.iterator(); ent.hasNext(); ){
    		System.out.println("  element: "+ent.next()+"\n");
    	}
		*/
		List<List> cont = fillListOfLists();
	    printListOfLists(cont);
				
	}

	public static List<String> fillStringList(){
    	
	    List<String> strList = new ArrayList<String>();
	    
	    strList.add(new String("mama"));
	    strList.add(new String("papa"));
	    strList.add(new String("bratik"));
	return  strList;
	}
	
	                                                                                                                                  
	public static List fillListOfLists(){
    	
    List<String> strList = new ArrayList<String>();
    
    strList.add(new String("mama"));
    strList.add(new String("papa"));
    strList.add(new String("bratik"));
   
    List<List> container  = new ArrayList<List>();
    
    container.add(strList);
    
    List<String> strList2 = new ArrayList<String>();
    
    strList2.add(new String("babushka"));
    strList2.add(new String("dedushka"));
    strList2.add(new String("pradedushka"));
    strList2.add(new String("prababushka"));
    
    container.add(strList2);
    
    return  container;
    }
    
    public static void printListOfLists(List<List> c){
    	
    	for (Iterator<List> r = c.iterator(); r.hasNext(); ){
            System.out.println("next record\n");
            List cl = r.next();
            
        	for (Iterator<String> ent = cl.iterator(); ent.hasNext(); ){
        		String s = ent.next();
        		System.out.println("  element: "+s+"\n");
        	}
            System.out.println("\n");
    	}
    }
    
}
