package org.szi.lng.patterns;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/26/2012
 * Time: 11:17 AM
 * To change this template use File | Settings | File Templates.
 */

interface Calculator {
    public void calculate(double operand);
    public double getResult();
}

abstract class CalculatorTemplate implements Calculator {
private double result;
private boolean initialized = false;
public final void calculate(double operand) {
        if (this.initialized) {
        this.result = this.doCalculate(this.result, operand);
       } else {
          this.result = operand;
          this.initialized = true;
        }
}
public final double getResult() {
        return this.result; // throw exception if !initialized
}
 public abstract double doCalculate(double o1, double o2);
}

class AdditionCalculator extends CalculatorTemplate {
      public double doCalculate(double o1, double o2) {return o1 + o2; }
}

 class SubtractionCalculator extends CalculatorTemplate {
    public double  doCalculate(double o1, double o2) {return o1 - o2; }
}



public class TemplateDesignTest {

    public static void main(String[] args) {
        Calculator c1 = new AdditionCalculator();
        Calculator c2 = new SubtractionCalculator();
        c1.calculate(10);
        System.out.println("calculator aft first call: " + c1.getResult());
        c1.calculate(20);
        System.out.println("calculator aft 2nd call: " + c1.getResult());
    }

}
