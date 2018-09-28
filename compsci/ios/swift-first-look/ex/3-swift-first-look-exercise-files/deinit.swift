import Foundation

class Observer: NSObject {
    
    deinit {
        println("So long!")
        let nc = NSNotificationCenter.defaultCenter()
        nc.removeObserver(self, name: "TheBigEvent", object: nil)
    }

    override init() {
        super.init()

        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "processBigEvent:", name: "TheBigEvent", object: nil)
    }
    
    // MARK: - Notification Handling
    
    func processBigEvent(notification: NSNotification) {
        println("Whoa! Looks like a Big Event has occurred")
    }
}

let notification = NSNotification(name: "TheBigEvent", object: nil)
let nc = NSNotificationCenter.defaultCenter()

// If a notification is posted in the woods, does anyone observe it?
nc.postNotification(notification)

var observers = [Observer()]
//let observer = Observer()
nc.postNotification(notification)

observers.removeAll()
nc.postNotification(notification)

