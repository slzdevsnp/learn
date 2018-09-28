package org.szi.lrn.m2_intro_java_abtsr_mechanism.withabstractclass;

import org.szi.lrn.m2_intro_java_abtsr_mechanism.ClientEngagement;

import static org.szi.lrn.m2_intro_java_abtsr_mechanism.withabstractclass.FixedFeeCalculator.STANDARD_FEE;
import static org.szi.lrn.m2_intro_java_abtsr_mechanism.withabstractclass.RoyaltyShareCalculator.STANDARD_ROYALTY_PERCENTAGE;

/**
 * Created by zimine on 3/4/18.
 */


public class RevenueCalculatorRunner {

    public static void main(String[] args){


        final ClientEngagement clientEngagement = new ClientEngagement("Pluralsight", 100, 15000);


        System.out.println("Revenue calculator using Abstract classes for implementation");
        System.out.println("each model has a dedicated implementation class with a logic split by the model");


        RevenueCalculator  revenueCalculator = new FixedFeeCalculator(STANDARD_FEE); //polymorphism

        double price = revenueCalculator.calculate(clientEngagement);

        System.out.println("FixedFee model is: " + price);

        // 2nd model
        revenueCalculator = new HourlyRateCalculator(); //default constructor has a standard hourly fee
        price = revenueCalculator.calculate(clientEngagement);
        System.out.println("Hourly rate model price: " + price);


        //3rd model
        revenueCalculator = new RoyaltyShareCalculator(STANDARD_ROYALTY_PERCENTAGE + 0.02); //percentage + negotiated
        price = revenueCalculator.calculate(clientEngagement);
        System.out.println("Royalty model price: " + price);

    }
}
