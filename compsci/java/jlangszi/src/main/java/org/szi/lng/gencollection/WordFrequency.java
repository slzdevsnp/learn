package org.szi.lng.gencollection;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/24/2012
 * Time: 7:58 PM
 * To change this template use File | Settings | File Templates.
 */
public class WordFrequency {


    static void getWordFrequency(InputStream in, Map wordMap)
            throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(in));
        int ch = -1;
        StringBuffer word = new StringBuffer();

        while ((ch = reader.read()) != -1) {
            if ( ch == '0') { break ; }
            if (Character.isWhitespace(ch)) {
                if (word.length() > 0) {
                    putCountWord(wordMap, word.toString());
                    word = new StringBuffer();
                }
            } else {
                word.append((char) ch);
            }
        }
        if (word.length() > 0) {
            putCountWord(wordMap, word.toString());
        }
    }

    static void putCountWord(Map wordMap, String word) {  // Map object passed by reference, updated in parent stack
        Integer count = (Integer) wordMap.get(word);
        if (count == null) {
            count = new Integer(1);
        } else {
            count = new Integer(count.intValue() + 1);
        }
        wordMap.put(word, count);
    }

    static void testWordFrequency() throws IOException{
        Map wordMap = new HashMap();
        System.out.println("enter an array of words. 0 to terminate");
        getWordFrequency(System.in, wordMap);
        //print results
        System.out.println("words frequency");
        for (Iterator i = wordMap.entrySet().iterator(); i.hasNext();) {
            Map.Entry entry = (Map.Entry) i.next();
            System.out.println(entry.getKey() + " :\t" + entry.getValue());
        }
    }

    public static void main(String[] args) throws IOException{
          testWordFrequency();
    }
}
