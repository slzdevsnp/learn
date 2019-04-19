package org.szi.lng.gencollection;

import java.util.List;
import java.util.ArrayList;

/**
 * User: slava
 * Date: Aug 9, 2009
 * Time: 2:43:25 AM
 * Class usage:
 */
public class GenericTester {

    //inner class
    class GenHolder<V>{
        V  value;

        GenHolder(V in){ value = in;}

        V getValue(){ return value;}



        public String toString(){
            String out = "";
            if (value instanceof String){
                String val = (String) value;
                out = " String version: " + value;
            }
            else if (value instanceof Integer){
                out = " Integer version: " + value;
            }
            else {
                out  = " default version: " + value;
            }
            return out;
        }
    }

    public static void main(String[] args) {
       GenericTester gt = new GenericTester();
        gt.test();
    }

    void test(){
        GenHolder<String> gs = new GenHolder<String>("mama");
        System.out.println(gs);

        GenHolder<Integer> gi = new GenHolder<Integer>(10);
         System.out.println(gi);

        List<GenHolder<Double>> gl = new ArrayList<GenHolder<Double>>();
        gl.add(new GenHolder<Double>(1.0));
        gl.add(new GenHolder<Double>(2.0));
        gl.add(new GenHolder<Double>(3.0));

        for (GenHolder<Double> el: gl)
            System.out.println("list element: " + el);


    }

}
