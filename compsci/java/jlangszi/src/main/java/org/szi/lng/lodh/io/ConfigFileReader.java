/**
 * 
 */
package org.szi.lng.lodh.io;

import java.io.FileReader;
import java.io.BufferedReader;
import java.io.IOException;

/**
 * @author zimine
 *
 */
public class ConfigFileReader {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		if (args.length != 1){
			usage();
		    System.exit(1);
		}
		String fpath = new String(args[0]);
		
		readLines(fpath);
	}
	public static void usage(){
		System.out.println("Usage: FileReader path_to_file\n\n");
	 }
  
	public static void readLines(String fp) {
        BufferedReader inputStream = null;
        try {
            inputStream =  new BufferedReader(new FileReader(fp));
            
            String l;
            while ((l = inputStream.readLine()) != null) {
                System.out.println(l);
            }
        
           //after processing
           if (inputStream != null) {
             inputStream.close();
           }
        }
        catch (IOException e) {
	      System.err.println("Caught IOException: " 
	                      + e.getMessage());
        } 
	}
  
}

