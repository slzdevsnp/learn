package org.szi.lrn.m3_understand_need4abstraction.revenue;
//Created on 3/4/18


public class FixedFeeCalculator implements RevenueCalculator {

        private double fee;

        public static final double STANDARD_FEE = 500;

        public FixedFeeCalculator(final double fee){
            this.fee = fee;
        }
        public FixedFeeCalculator() {
            this.fee = STANDARD_FEE;
        }

        @Override
        public  double calculate(ClientEngagement clientEngagement){
            return fee;
        }
}
