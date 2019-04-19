package org.szi.lng.nio;

/**
 * Created by IntelliJ IDEA.
 * User: szi
 * Date: 31 mai 2009
 * Time: 19:51:56
 * To change this template use File | Settings | File Templates.
 **/

import java.nio.*;

 public class nioUseFloatBuffer
 {
   static public void main( String args[] ) throws Exception {
     FloatBuffer buffer = FloatBuffer.allocate( 10 );

     for (int i=0; i<buffer.capacity(); ++i) {
       float f = (float)Math.sin( (((float)i)/10)*(2*Math.PI) );
       buffer.put( f );
         System.out.println(f);
     }

     buffer.flip(); // rewind position to the beginning of buffer

       System.out.println("  after flipping");

     while (buffer.hasRemaining()) {
       float f = buffer.get();
       System.out.println( f );
     }
   }
 }
