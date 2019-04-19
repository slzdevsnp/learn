package org.szi.lng.lodh.exsys;
import java.io.*;
public class TestCommandExecution {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		if (args.length != 1){
			usage();
		    System.exit(1);
		}
		BufferedReader br = null;
        br = SysComExecutor.executeCommand(args[0]);
	}

public static void usage(){
	System.out.println("program to test from java execution of system commands.\n");
	System.out.println("Usage: TestCommmandexecution \"system command\"\n\n");
	System.out.println("The multiword command should be put in quotes\n");

 }
}
