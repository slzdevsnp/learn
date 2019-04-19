package org.szi.lng.nio;

/**
 * Created by IntelliJ IDEA.
 * User: szi
 * Date: 31 mai 2009
 * Time: 20:18:14
 * To change this template use File | Settings | File Templates.
 */

import java.io.*;
import java.nio.*;
import java.nio.channels.*;

public class nioCopyFile
{
  static public void main( String args[] ) throws Exception {
    if (args.length<2) {
      System.err.println( "Usage: java CopyFile infile outfile" );
      System.exit( 1 );
    }

    String infile = args[0];
    String outfile = args[1];

    FileInputStream fin = new FileInputStream( infile );
    FileOutputStream fout = new FileOutputStream( outfile );

    FileChannel fcin = fin.getChannel();
    FileChannel fcout = fout.getChannel();

    ByteBuffer buffer = ByteBuffer.allocate( 1024 );

    while (true) {
      buffer.clear();    // resets the buff

      int r = fcin.read( buffer );

      if (r==-1) {
        break;
      }

      buffer.flip();     // moves cursor back to the beginning before writing

      fcout.write( buffer );
    }
  }
}

