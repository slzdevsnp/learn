package org.szi.lng.patterns;

import java.io.*;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/25/2012
 * Time: 2:46 PM
 * To change this template use File | Settings | File Templates.
 */


 //decorated   FilterOutputStream with additional field counter

class ByteCounterOutputStream extends FilterOutputStream {
 private int counter = 0;
 public ByteCounterOutputStream(OutputStream out) {super(out);}

 public void write(int b) throws IOException {
      super.write(b);
     this.counter++;
 }
public int getCounter() {return this.counter;}
}


 class Decorator {

    public static void main(String[] args) throws FileNotFoundException, IOException {
        String foutname = "somefile";
        String finname = "somefile";
        InputStream in = new FileInputStream(finname);
        OutputStream out = new FileOutputStream(foutname);
        out = new BufferedOutputStream(out); // buffer before writing
        ByteCounterOutputStream bout = new ByteCounterOutputStream(out);

        for (int b = in.read(); b != -1; b = in.read()) {
            bout.write(b);
        }
        System.out.println("Written "+ bout.getCounter() + " bytes");  //additonal field is exposed


    }
}
