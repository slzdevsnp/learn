package org.szi.lng.patterns;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/26/2012
 * Time: 6:58 AM
 * To change this template use File | Settings | File Templates.
 */


interface Message{
    String getContents();

}

abstract class MessageHandler {
    private MessageHandler next;
    public MessageHandler(MessageHandler next) {
        this.next = next;
    }
    public void handle(Message message) {
        if (this.next != null) {this.next.handle(message); }
    }
}

class SpamHandler extends MessageHandler {        //derived actual class
    public SpamHandler(MessageHandler next) {
        super(next);
    }
        boolean isSpam(Message msg){
            return false;
            //check spam logic
        }

    public void handle(Message message) {
        if (isSpam(message)) {
            // handle spam
        } else {
            super.handle(message);
        }
    }
    //other methods
}




class ChainOfResponsibility {

    public static void main(String[] args) {
        //if a client makes instance
        //MessageHandler handler = new SpamHandler( new ForwardingHandler(new DeliveryHandler())) ;
        // handler.handle(emailMessage) ;
    }
}
