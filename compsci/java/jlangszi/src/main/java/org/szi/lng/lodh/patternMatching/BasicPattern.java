package org.szi.lng.lodh.patternMatching;

public class BasicPattern {

	/**
	 * @param args
	 */
	public static void main(String[] args) {

		//testStringIndex();
		testPatternMatching();	
        testPatternMatching2();
	}
	
	private static void testPatternMatching(){
		
		String s = "#this is a comment";
		String rgxp = "\\s*#.*";
		System.out.println("Matched? "+s.matches(rgxp));
	}

    private static void testPatternMatching2(){

        String s = "1.2345";
        String rgxp = "\\d+\\.\\d+";
        System.out.println("Matched float? "+ s.matches(rgxp));
    }

	
    private static void testStringIndex(){
    	
    	String s = "papa=mama";
        char del = '=';
    	
    	int res1 = s.indexOf(del);
    	int res2 = s.indexOf(del);
    	int res3 = s.lastIndexOf(del);
            	
    	System.out.println("res1 "+res1);
    	System.out.println("res2 "+res2);
    	System.out.println("res3 "+res3);

    }
}
