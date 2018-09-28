package org.szi.lrn.m2_intro_java_abtsr_mechanism.notabsract;

import org.szi.lrn.m2_intro_java_abtsr_mechanism.ClientEngagement;
public class RevenueCalculatorRunner
{
    public static void main(String[] args)
    {
        final ClientEngagement clientEngagement =
                new ClientEngagement("Pluralsight", 100, 15000);

        // "Hourly"
        // "FixedFee"
        // "RoyaltyPercentage"

        System.out.println("Revenue calculator without abstraction. RevenueCalculator  is a God class!..");

        final double hourlyPrice = RevenueCalculator.price("Hourly", clientEngagement);
        System.out.println("hourlyPrice = " + hourlyPrice);

        final double fixedFeePrice = RevenueCalculator.price("FixedFee", clientEngagement);
        System.out.println("fixedFeePrice = " + fixedFeePrice);

        final double royaltyPercentagePrice = RevenueCalculator.price("RoyaltyPercentage", clientEngagement);
        System.out.println("royaltyPercentagePrice = " + royaltyPercentagePrice);
    }
}