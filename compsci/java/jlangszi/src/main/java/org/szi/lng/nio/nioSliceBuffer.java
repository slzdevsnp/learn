package org.szi.lng.nio;

/**
 * Created by IntelliJ IDEA.
 * User: szi
 * Date: 1 juin 2009
 * Time: 12:41:28
 * To change this template use File | Settings | File Templates.
 */

import java.io.*;
import java.nio.*;
import java.nio.channels.*;

public class nioSliceBuffer
{
  static public void main( String args[] ) throws Exception {
    ByteBuffer buffer = ByteBuffer.allocate( 10 );

    for (int i=0; i<buffer.capacity(); ++i) {
      buffer.put( (byte)i );
    }

    buffer.position( 3 );
    buffer.limit( 7 );

    ByteBuffer slice = buffer.slice();

    for (int i=0; i<slice.capacity(); ++i) {
      byte b = slice.get( i );
      b *= 11;
      slice.put( i, b );
    }

    buffer.position( 0 );
    buffer.limit( buffer.capacity() );

    while (buffer.remaining()>0) {
      System.out.println( buffer.get() );
    }
  }


}

