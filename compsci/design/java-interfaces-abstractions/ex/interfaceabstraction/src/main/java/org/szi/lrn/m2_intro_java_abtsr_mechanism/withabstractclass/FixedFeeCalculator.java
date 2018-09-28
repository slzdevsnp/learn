package org.szi.lrn.m2_intro_java_abtsr_mechanism.withabstractclass;

import org.szi.lrn.m2_intro_java_abtsr_mechanism.ClientEngagement;

/**
 * Created by zimine on 3/4/18.
 */
public class FixedFeeCalculator  extends RevenueCalculator {

    private double fee;

    public static final double STANDARD_FEE = 500;

    public FixedFeeCalculator(final double fee){
        this.fee = fee;
    }



    @Override
    public  double calculate(ClientEngagement clientEngagement){
        return fee;
    }

}
