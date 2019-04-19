package org.szi.lng.gencollection;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/24/2012
 * Time: 7:06 PM
 * To change this template use File | Settings | File Templates.
 */
class Sort {

    static void testSortingList() throws IOException{
        System.out.println("enter words as input, type end to finish.");
        List lines = new ArrayList();
        Set els = new HashSet();
        BufferedReader reader = new BufferedReader(new InputStreamReader(
                System.in));
        String line = null;
        while ((line = reader.readLine()) != null) {
            if (line.compareTo("end") == 0) { break; }
            lines.add(line);
            els.add(line);
        }
        Collections.sort(lines);   //call a static method
        System.out.println("sorted collection");
        for (Iterator i = lines.iterator(); i.hasNext();) {
            System.out.println(i.next());
        }
        System.out.println("hashSet");
        for (Iterator i = els.iterator(); i.hasNext();) {
            System.out.println(i.next());
        }

    }


    public static void main(String[] args) throws IOException {
        testSortingList();
    }
}
