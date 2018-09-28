package org.szi.boot;//Created on 3/9/18

import org.junit.Test;
import org.szi.boot.controller.HomeController;

import static org.junit.Assert.assertEquals;

public class AppTest
{
    @Test
    public void testApp()
    {
        HomeController hc = new HomeController();
        String result= hc.home();
        assertEquals(result, "Das boot, reporting for duty");
    }
}

