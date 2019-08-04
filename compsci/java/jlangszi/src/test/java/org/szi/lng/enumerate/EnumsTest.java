package org.szi.lng.enumerate;

import org.assertj.core.api.Assertions;

import org.junit.Test;


enum RotateFrequency{
    M1,M3,M10,H1,H3,D1;

    public int getPeriodSeconds(){
        int period = -1;
        switch(this){
            case M1: period = 60; break;
            case M3: period =  180; break;
            case M10: period = 600; break;
            case H1: period = 3600; break;
            case H3: period =  10800; break;
            case D1: period =  86400; break;
            default:  period = 0; break; //should never reach
        }
        return period;
    }

}


public class EnumsTest {


    @Test
    public void dumyTest() {
        Assertions.assertThat(true);
    }

    @Test
    public void testAssignWithString(){
        RotateFrequency f1 = RotateFrequency.M1;
        RotateFrequency  f2 = RotateFrequency.valueOf("M1");
        Assertions.assertThat(f1).isEqualByComparingTo(f2);
    }

    @Test
    public void testPeriod(){
        RotateFrequency d1 = RotateFrequency.D1;
        Assertions.assertThat(d1.getPeriodSeconds()).isEqualTo(86400);
    }

}



