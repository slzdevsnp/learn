package org.szi.lrn.m3_understand_need4abstraction.revenue;//Created on 3/4/18


import static org.szi.lrn.m3_understand_need4abstraction.revenue.FixedFeeCalculator.STANDARD_FEE;
import static org.szi.lrn.m3_understand_need4abstraction.revenue.HourlyRateCalculator.STANDARD_HOURLY_RATE;
import static org.szi.lrn.m3_understand_need4abstraction.revenue.RoyaltyShareCalculator.STANDARD_ROYALTY_PERCENTAGE;



import java.util.ArrayList;
import java.util.List;

public class SalesPredictorRunner {

    public static void main(String[] args){

        List<ClientEngagement> engagements = new ArrayList<ClientEngagement>();

        engagements.add(new ClientEngagement("Catherine's Cookies", 40, 40_000));
        engagements.add(new ClientEngagement("Bob's Burgers", 30, 4000));
        engagements.add(new ClientEngagement("Dave's Doughnuts", 25, 1000));
        engagements.add(new ClientEngagement("Susan's Sausages", 10, 2000));


        System.out.println("### revenue calculator models implemented with interface");

        System.out.println("Fixed fee model for a list of clients");
        printTotalValue(engagements, new FixedFeeCalculator(STANDARD_FEE));

        System.out.println("Hourly rate model dor a list of clients");
        printTotalValue(engagements, new HourlyRateCalculator(STANDARD_HOURLY_RATE));

        System.out.println("Rotaltyshare model dor a list of clients");
        printTotalValue(engagements, new RoyaltyShareCalculator(STANDARD_ROYALTY_PERCENTAGE));

    }

    private static void printTotalValue(List<ClientEngagement> engagements,
                                        final RevenueCalculator revenueModel)
    {
        double total = 0;
        for (ClientEngagement clientEngagement : engagements)
        {
            total += revenueModel.calculate(clientEngagement);
        }
        System.out.println("model total = " + total);
    }

}
