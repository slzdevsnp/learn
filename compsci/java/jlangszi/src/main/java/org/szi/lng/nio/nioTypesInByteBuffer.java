package org.szi.lng.nio;

/**
 * Created by IntelliJ IDEA.
 * User: szi
 * Date: 31 mai 2009
 * Time: 20:52:26
 * To change this template use File | Settings | File Templates.
 */

import java.io.*;
import java.nio.*;
import java.nio.channels.*;

public class nioTypesInByteBuffer {

  static public void main( String args[] ) throws Exception {
    ByteBuffer buffer = ByteBuffer.allocate( 64 );

    buffer.putInt( 30 );
    buffer.putLong( 7000000000000L );
    buffer.putDouble( Math.PI );

    buffer.flip();

    System.out.println( buffer.getInt() );
    System.out.println( buffer.getLong() );
    System.out.println( buffer.getDouble() );
  }
}
