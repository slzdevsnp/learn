
import Foundation

class Observer: NSObject {
    
    deinit {
        print("So long")
        let nc = NotificationCenter.default
        nc.removeObserver(self
                        ,name: NSNotification.Name(rawValue: "TheBigEvent")
                        ,object: nil )
    }
    
    
    override init(){
        super.init()
  
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: "processBigEvent:", name: Notification.Name(rawValue: "TheBigEvent"), object: nil)
  
    }
    
    func processBigEvent(notification: Notification) {
        print("Whoa! Looks like a Big Event has occurred")
    }
    
}


let notification = Notification(name: NSNotification.Name(rawValue: "TheBigEvent"), object: nil)

let nc = NotificationCenter.default
nc.post(notification)
var observers = [Observer()]
//nc.post(notification)

observers.removeAll()
//nc.post(notification)