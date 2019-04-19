package org.szi.lng.concurrent.fileReaderProdCons;

/**
 * Created by IntelliJ IDEA.
 * User: slava
 * Date: Apr 20, 2009                     
 * Time: 5:10:47 PM
 * To change this template use File | Settings | File Templates.
 */
public class TestIOBufferProcessing {

    public static void main(String[] args) {

        /*
        if (args.length != 1){
            usage();
            System.exit(1);
        }
        */

        //String fpath = new String(args[0]);
        String fpath =  "/Users/zimine/marketdata/fx/oandaTicks/EURUSD/EURUSD_19-47-24-7-9.txt";
        int bufferLength = 100;
        TextBuffer tb = new TextBuffer();

        BufferProcessor bp = new BufferProcessor(tb);
         new Thread(bp, "BufProc").start();

        BufferReader br = new BufferReader(fpath, tb, bufferLength);
         new Thread(br, "BufRead").start();
        
    }

    public static void usage(){
        System.out.println("Usage: TestIOBufferProcessing path_to_file\n\n");
     }



}


