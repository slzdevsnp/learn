package org.szi.lng.ofobj;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.LinkedHashMap;

public class TestCollectionOfChilds {
  
	
	
	public static void main(String[] args){
		
		List<Parent> ol = new ArrayList<Parent>(); //compiles but warns for unsafe operations
        //List<Object> ol = new ArrayList<Object>();

        ChildA  a1 = new ChildA("vasya", new Integer(10));
		ChildB  b1 = new ChildB("petya", "good pupil");
		ChildA  a2 = new ChildA("kolya", new Integer(15));
        ChildA  a3 = new ChildA("Serega", new Integer(25));

		ol.add(a1);
		ol.add(b1);
		ol.add(a2);
        ol.add(a3);
		
		//iteration
		for (Object o : ol){
            Parent p = (Parent)o;
			System.out.println(p.getName());
		}

        //maps
        Map<Long, ChildA> map = new LinkedHashMap();

        map.put(new Long("111111"), a1);
        map.put(new Long("222222"),  a2);
        map.put(new Long("33333"),  a3);

		
	}
}
