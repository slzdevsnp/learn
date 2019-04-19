package org.szi.lng.str;

/**
 * Created by IntelliJ IDEA.
 * User: slava
 * Date: Aug 1, 2009
 * Time: 4:07:22 PM
 * To change this template use File | Settings | File Templates.
 */
public class JsplitTester {

    static void splitDateString(String dateStr){
        String[] dates;
        int year = 1970;
        int month = 1;
        int day_of_month = 1;
        try{
        dates = dateStr.split("/");
            if (dates.length != 3)
                throw new Exception("illegal maturity Date format. " + dateStr +
                        " Expected year/month/day");

            year = new Integer(dates[0]);
            month = new Integer(dates[1]);
            day_of_month = new Integer(dates[2]);
            if (year < 0 )  throw new Exception("incorrect year " + year );
            if (month < 1 ||  month > 12) throw new Exception("incorrect month " + month);
            if (day_of_month < 1 ||
                     day_of_month > 30) throw new Exception("incorrect day " + day_of_month);
        }catch (Exception e) {
           e.printStackTrace();
        }
        System.out.println("year month  day: " + year + " "+ month + " "+ day_of_month);

    }

    public static void main(String[] args) {
           splitDateString("2009/2/2");
           splitDateString("2009/-1");
    }
}
