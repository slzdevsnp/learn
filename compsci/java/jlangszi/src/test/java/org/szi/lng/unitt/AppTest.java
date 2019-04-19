package org.szi.lng.unitt;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

public class AppTest {

	private App target = null;

	@Before
	public void setUp(){
	    target = new App();
	}
	
   @Test
    public void testApp()
    {
       //prepare
	   target.setAppName("dummyName");
	   
	   //verify
        Assert.assertNotNull(target);
        Assert.assertEquals("dummyName",target.getAppName());
    }
}
