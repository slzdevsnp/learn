package org.szi.lng.lang;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/24/2012
 * Time: 11:37 AM
 * To change this template use File | Settings | File Templates.
 */
public class StringBuilderTest {

      static void stringConcatenationTest(int count){
          String s = "";
          long time = System.currentTimeMillis();
          for (int i = 0; i < count; i++) {
              s += ".";
          }
          time = System.currentTimeMillis() - time;
          System.out.println("stringConcatenationTest duration (ms): " + time);
      }

       static void stringBuilderTest(int count) {
           StringBuilder sb = new StringBuilder();
           long time = System.currentTimeMillis();
           for (int i = 0; i < count; i++) {
               sb.append(".");
           }
           sb.trimToSize();
           time = System.currentTimeMillis() - time;
           System.out.println("stringBuilderTest duration (ms): " + time);
       }
       static void compareConcatVsBuilder(int count){
           stringConcatenationTest(count);
           stringBuilderTest(count);
       }




    public static void main(String[] args) {
        int tcount = 30000;
         compareConcatVsBuilder(tcount);
    }

}
