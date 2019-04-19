package org.szi.lng.str;

/**
 * Created by IntelliJ IDEA.
 * User: szi
 * Date: 1 juin 2009
 * Time: 23:24:54
 * To change this template use File | Settings | File Templates.
 */
public class Splitter {

    public static void main(String[] args) {
        String testStr =   "5/2/2009,7:59:53:689,0,0,2945.0,2906.5,0,0";
        char fd = ',';
       // String res = extractField(testStr, fd, 0);
        System.out.println("field: " + extractField(testStr, fd, 0));
        System.out.println("field: " + extractField(testStr, fd, 1));
        System.out.println("field: " + extractField(testStr, fd, 2));
        System.out.println("field: " + extractField(testStr, fd, 4));
        System.out.println("field: " + extractField(testStr, fd, 5));

    }
    private static String  extractField(String s, char fd, int fnumber){
       int offset=0;
       int indexStart=0;
       int finoffset = 0;
       for (int i = 0; i < fnumber; i++){
           indexStart = s.indexOf(fd,offset);
           offset = indexStart+1;
       }
       if (fnumber > 0) finoffset = 1;
       int indexEnd = s.indexOf(fd,indexStart + finoffset);
       // System.out.println("stop start indices: "+ indexStart + " " + indexEnd);
        String res = s.substring(indexStart + finoffset, indexEnd);
       return res;
    }
}
