package org.szi.lng.IO;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/24/2012
 * Time: 12:00 PM
 * To change this template use File | Settings | File Templates.
 */
import java.io.File;
public class RemoveFIe {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.err.println("Usage: Remove <file|directory>...");
        }
        for (int i = 0; i < args.length; i++) {
            remove(new File(args[i]));
        }
    }
    private static void remove(File file) {
        if (!file.exists()) {
            System.err.println("No such file or directory: "
                    + file.getAbsolutePath());
        } else if (file.isDirectory() && file.list().length > 0) {
            System.err.println("Directory contains files: "
                    + file.getAbsolutePath());
        }
        else if (!file.delete()) {
            System.err.println("Could not remove: " + file.getAbsolutePath());
        }
    }

}
