package org.szi.lng.enumerate;


enum Human {
    MALE,
    FEMALE,
    UNKNOWN;

    static public Human findMales(Males m){
        Human res;
        switch (m){
            case BOY:  res =  Human.MALE ;
                break;
            case MAN:  res = Human.MALE ;
                break;
            case OLDMAN: res =  Human.MALE ;
            break;
            default :  res = Human.UNKNOWN;
        }
        return res;
    }

     static public Human findFemales(Females f){
        Human res;
        switch (f){
            case GIRL:  res =  Human.FEMALE ;
                break;
            case WOMAN :  res = Human.FEMALE ;
                break;
            case OLDY : res =  Human.FEMALE ;
                break;
            default :  res = Human.UNKNOWN;
        }
        return res;
    }


}

enum Females {
    GIRL,
    WOMAN,
    OLDY;
}

enum Males {
    BOY,
    MAN,
    OLDMAN;
}



public class Twoenums {

    public static void main(String[] args) {

    Males p1 = Males.BOY;
    Human h1 = Human.findMales(p1);
    System.out.println("for male:" + p1 + " human: " + h1);

    Females m1 = Females.OLDY;
    Human h2 = Human.findFemales(m1);
    System.out.println("for 2nd person:" + m1 + " human: " + h2);



    }

}
