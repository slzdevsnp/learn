package org.szi.lng.patterns;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;


interface Subject {
    public void addObserver(Observer o);
    public void removeObserver(Observer o);
    public String getState();
    public void setState(String state);
    public void notifyObservers();
}

interface Observer {
    public void update(Subject o);
}


class ObserverImplA implements Observer {
    private String state= "";

    public void update(Subject o) {
        state= o.getState();
        System.out.println("Update observerA received from Subject, state changed to : " + state);
    }
}
class ObserverImplB implements Observer {
        private String state= "";
        private int counter = 0;

        public void update(Subject o) {
            state= o.getState();
            counter++;
            System.out.println("Update observerB received from Subject, state changed to : "
                              + state + " for the " +  counter + " nth count");
        }
 }

class SubjectImpl implements Subject {
    private List observers = new ArrayList();      //a collection of observers

    private String state = "";

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
        notifyObservers();
    }

    public void addObserver(Observer o) {
        observers.add(o);
    }

    public void removeObserver(Observer o) {
        observers.remove(o);
    }

    public void notifyObservers() {
        Iterator i = observers.iterator();
        while (i.hasNext()) {
            Observer o = (Observer) i.next();
            o.update(this);                     //update of observer with  new state of Subject
        }
    }
}


class ObserverTest{

    static void testNotifyObservers(){

        Observer oa = new ObserverImplA();
        Observer ob = new ObserverImplB();
        Subject s = new SubjectImpl();
        s.addObserver(oa);    //setting collection of observables in subject
        s.addObserver(ob);
        //updating the subject
        s.setState("New State");
    }


    public static void main(String[] args) {

        testNotifyObservers();
    }

}

