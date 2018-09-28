package org.szi.lrn.m2_intro_java_abtsr_mechanism.withabstractclass;

import  org.szi.lrn.m2_intro_java_abtsr_mechanism.ClientEngagement;


public class RoyaltyShareCalculator extends RevenueCalculator {

    public static final double STANDARD_ROYALTY_PERCENTAGE = 0.15;

    private final double royaltyPercentage;

    public RoyaltyShareCalculator(final double royaltyPercentage)
    {
        this.royaltyPercentage = royaltyPercentage;
    }

    @Override
    public double calculate(final ClientEngagement clientEngagement)
    {
        return royaltyPercentage * clientEngagement.getAnticipatedRevenue();
    }
}
