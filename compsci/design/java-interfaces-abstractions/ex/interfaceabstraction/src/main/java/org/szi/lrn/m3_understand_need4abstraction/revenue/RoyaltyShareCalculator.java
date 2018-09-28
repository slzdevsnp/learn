package org.szi.lrn.m3_understand_need4abstraction.revenue;//Created on 3/4/18

public class RoyaltyShareCalculator  implements RevenueCalculator {

    public static final double STANDARD_ROYALTY_PERCENTAGE = 0.15;

    private final double royaltyPercentage;


    public RoyaltyShareCalculator(final double royaltyPercentage){
        this.royaltyPercentage = royaltyPercentage;
    }

    public RoyaltyShareCalculator(){
        this.royaltyPercentage = STANDARD_ROYALTY_PERCENTAGE;
    }


    @Override
    public double calculate(ClientEngagement clientEngagement){
        return clientEngagement.getAnticipatedRevenue() * royaltyPercentage;
    }
}
