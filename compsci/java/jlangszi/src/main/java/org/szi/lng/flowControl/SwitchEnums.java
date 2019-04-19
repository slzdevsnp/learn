package org.szi.lng.flowControl;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/20/2012
 * Time: 6:08 PM
 * To change this template use File | Settings | File Templates.
 */
public class SwitchEnums {

    enum Day { SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY }

    static void monthFromNumber(String mstr){
        int month = Integer.parseInt(mstr);
         switch(month){
             case 1:  System.out.println("January"); break;
             case 2:  System.out.println("February");break;
             case 3:  System.out.println("March"); break;
             case 4:  System.out.println("April"); break;
             case 5:  System.out.println("May"); break;
             case 6:  System.out.println("June"); break;
             case 7:  System.out.println("July"); break;
             case 8:  System.out.println("August"); break;
             case 9:  System.out.println("September"); break;
             case 10: System.out.println("October"); break;
             case 11: System.out.println("November"); break;
             case 12: System.out.println("December"); break;
             default: System.out.println("Invalid month: " + month);
         }
    }
    static void iterEnum(){

        for (Day d: Day.values()) {
            System.out.println("enum day:" + d);
        }
    }



    public static void main(String[] args) {
           monthFromNumber("1");
           monthFromNumber("12");
           iterEnum();

           ChessPieceEnum cp = new ChessPieceEnum(ChessPieceEnum.Color.BLACK,  ChessPieceEnum.Figure.KING);
           System.out.println("chess piece: " + cp.toString() );
    }
}
