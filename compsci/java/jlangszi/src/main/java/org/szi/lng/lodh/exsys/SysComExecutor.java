package org.szi.lng.lodh.exsys;

import java.io.*;

public class SysComExecutor {


	
	public static BufferedReader executeCommand(String command) {
	      BufferedReader br_in = null;
	      BufferedReader br_err = null;
		    try {
		      String[] finalCommand;
		      if (isWindows()) {
		        finalCommand = new String[4];
		        // Use the appropriate path for your windows version.
		        finalCommand[0] = "C:\\windows\\system32\\cmd.exe";  // Windows XP/2003
		        //finalCommand[0] = "C:\\winnt\\system32\\cmd.exe";  // Windows NT/2000
		        finalCommand[1] = "/y";
		        finalCommand[2] = "/c";
		        finalCommand[3] = command;
		      }
		      else {
		        finalCommand = new String[3];
		        finalCommand[0] = "/bin/sh";
		        finalCommand[1] = "-c";
		        finalCommand[2] = command;
		      }
		      final Process pr = Runtime.getRuntime().exec(finalCommand);
		      //return process standard output streadm
		      br_in = new BufferedReader(new InputStreamReader(pr.getInputStream()));
		      
		      if (br_in != null){
		    	  String buff = null;
		    	  while ( (buff = br_in.readLine()) != null ){
		    		  System.out.println(buff);
		    	  }
		    	  br_in.close();
		      }
		      
		      //print process error stream
		      br_err = new BufferedReader(new InputStreamReader(pr.getErrorStream()));
		      if (br_err != null){
		    	  String buff = null;
		    	  while ( (buff = br_err.readLine()) != null ){
		    		  System.out.println(buff);
		    	  }
		    	  br_err.close();
		      }
		    }catch (Exception ex) {
		      System.out.println(ex.getLocalizedMessage());
		    }
		    return (br_in);
	}
	
	
	
	public static void executeCommandWThreads(String command) {
		    try {
		      String[] finalCommand;
		      if (isWindows()) {
		        finalCommand = new String[4];
		        // Use the appropriate path for your windows version.
		        finalCommand[0] = "C:\\windows\\system32\\cmd.exe";  // Windows XP/2003
		        //finalCommand[0] = "C:\\winnt\\system32\\cmd.exe";  // Windows NT/2000
		        finalCommand[1] = "/y";
		        finalCommand[2] = "/c";
		        finalCommand[3] = command;
		      }
		      else {
		        finalCommand = new String[3];
		        finalCommand[0] = "/bin/sh";
		        finalCommand[1] = "-c";
		        finalCommand[2] = command;
		      }
		  
		      final Process pr = Runtime.getRuntime().exec(finalCommand);
		      pr.waitFor();

		      new Thread(new Runnable(){
		        public void run() {
		          BufferedReader br_in = null;
		          try {
		            br_in = new BufferedReader(new InputStreamReader(pr.getInputStream()));
		            String buff = null;
		            while ((buff = br_in.readLine()) != null) {
		              System.out.println("Process out :" + buff);
		              try {Thread.sleep(1); } catch(Exception e) {}
		            }
		            br_in.close();
		          }
		          catch (IOException ioe) {
		            System.out.println("Exception caught printing process output.");
		            ioe.printStackTrace();
		          }
		          finally {
		            try {
		              br_in.close();
		            } catch (Exception ex) {}
		          }
		        }
		      }).start();
		  
		      new Thread(new Runnable(){
		        public void run() {
		          BufferedReader br_err = null;
		          try {
		            br_err = new BufferedReader(new InputStreamReader(pr.getErrorStream()));
		            String buff = null;
		            while ((buff = br_err.readLine()) != null) {
		              System.out.println("Process err :" + buff);
		              try {Thread.sleep(1); } catch(Exception e) {}
		            }
		            br_err.close();
		          }
		          catch (IOException ioe) {
		            System.out.println("Exception caught printing process error.");
		            ioe.printStackTrace();
		          }
		          finally {
		            try {
		              br_err.close();
		            } catch (Exception ex) {}
		          }
		        }
		      }).start();
		    }
		    catch (Exception ex) {
		      System.out.println(ex.getLocalizedMessage());
		    }
		  }
		  
		  public static boolean isWindows() {
		    if (System.getProperty("os.name").toLowerCase().indexOf("windows") != -1)
		      return true;
		    else
		      return false;
		  }
	
	

}
