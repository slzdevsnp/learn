package org.szi.lng.nio;

/**
 * Created by IntelliJ IDEA.
 * User: szi
 * Date: 1 juin 2009
 * Time: 12:50:39
 * To change this template use File | Settings | File Templates.
 */

import java.io.*;
import java.nio.*;
import java.nio.channels.*;

public class nioFastCopyFile
{
  static public void main( String args[] ) throws Exception {
    if (args.length<2) {
      System.err.println( "Usage: java FastCopyFile infile outfile" );
      System.exit( 1 );
    }

    String infile = args[0];
    String outfile = args[1];

    FileInputStream fin = new FileInputStream( infile );
    FileOutputStream fout = new FileOutputStream( outfile );

    FileChannel fcin = fin.getChannel();
    FileChannel fcout = fout.getChannel();

    ByteBuffer buffer = ByteBuffer.allocateDirect( 1024 );     //allocate Direct

    while (true) {
      buffer.clear();

      int r = fcin.read( buffer );

      if (r==-1) {
        break;
      }

      buffer.flip();

      fcout.write( buffer );
    }
  }
}
