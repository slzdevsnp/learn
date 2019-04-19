package org.szi.lng.timer;

import java.util.Map;
import java.util.LinkedHashMap;
import java.util.Set;
import java.util.Iterator;

/**
 * Created by IntelliJ IDEA.
 * User: slava
 * Date: Mar 6, 2009
 * Time: 12:53:42 PM
 * To change this template use File | Settings | File Templates.
 */
public  class ProfileTimer {

    private static Map<String,Long> m = new LinkedHashMap();




    public static void start(String message){
        long st = System.currentTimeMillis();
        m.put(message, new Long(st));
    }

    public static void end(){
        long et = System.currentTimeMillis();

        Map<String,Long> fm = new LinkedHashMap();

        Set entries = m.entrySet();
        Iterator iterator = entries.iterator();
        while (iterator.hasNext()) {
            Map.Entry entry = (Map.Entry)iterator.next();
            String cKey = (String)entry.getKey();
            Long   cVal = (Long)entry.getValue();
            long   cvalng = cVal.longValue();
            fm.put(cKey, new Long(et-cvalng));
        }
        m = fm;
    }

    public static void printTimings()
    {
        System.out.println("ProfileTimer timings (ms):\n");
        Set entries = m.entrySet();
        Iterator iterator = entries.iterator();
        while (iterator.hasNext()) {
            Map.Entry entry = (Map.Entry)iterator.next();
            System.out.println(entry.getKey() + " : " + entry.getValue() + "\n");
        }
     System.out.println();
   }

}
