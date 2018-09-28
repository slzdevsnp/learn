package org.szi.lrn.m3_understand_need4abstraction.revenue;//Created on 3/4/18

public class HourlyRateCalculator implements RevenueCalculator {

    public final static double STANDARD_HOURLY_RATE = 50;

    private double hourlyRate;

    public HourlyRateCalculator(double hourlyRate){
        this.hourlyRate = hourlyRate;
    }
    public HourlyRateCalculator(){
        this.hourlyRate = STANDARD_HOURLY_RATE;
    }

    @Override
    public double calculate(final ClientEngagement clientEngagement){
        return hourlyRate * clientEngagement.getHoursWorked();
    }
}


