package org.szi.lrn.m2_intro_java_abtsr_mechanism.withabstractclass;


import org.szi.lrn.m2_intro_java_abtsr_mechanism.ClientEngagement;

public class HourlyRateCalculator  extends  RevenueCalculator  {


    public static final double HOURLY_RATE = 50;  // usual hourly rate

    private double hourlyRate;

    public HourlyRateCalculator(final double hourlyRate){
        this.hourlyRate = hourlyRate;
    }

    public HourlyRateCalculator(){
        this.hourlyRate = HOURLY_RATE;
    }

    @Override
    public  double calculate(ClientEngagement clientEngagement){
        return this.hourlyRate * clientEngagement.getHoursWorked();
    }
}
