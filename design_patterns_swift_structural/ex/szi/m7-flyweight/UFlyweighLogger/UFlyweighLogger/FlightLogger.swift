//
//  FlightLogger.swift
//  UFlyweighLogger
//
//  Created by Sviatoslav Zimine on 9/25/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import Foundation
import os.log


public protocol FlyweightLogger: class { //class = limit the protocol adoption only
                                         // to class types, to avoid copying of intances
//value types are copied on assignment. This defeats the purpose of Flyweight pattern

    var subsystem: String {get} //read-only
    var category: String {get}
    
    init(subsystem: String, category: String)
    
    //OSLogType 5 levels of logging severity, defined in os.log module
    func log(_ message: String, type: OSLogType, file: String, function: String, line: Int)
}

//in extension provide defaults param values for log function
// We provide default argument values via a protocol extension rather than
//in protocol conforming types
extension FlyweightLogger {
    public func log(_ message: String, type: OSLogType,
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) {
        return log(message, type: type, file: file, function: function, line: line)
    }
}


// Log levels
extension OSLogType: CustomStringConvertible {
    public var description: String {
        switch self {
        case OSLogType.info:
            return "INFO"
        case OSLogType.debug:
            return "DEBUG"
        case OSLogType.error:
            return "ERROR"
        case OSLogType.fault:
            return "FAULT"
        default:
            return "DEFAULT"
        }
    }
}


// FlyweightLogger relies on the Unified System Logger introduced with iOS10
public class Logger: FlyweightLogger {
    public let subsystem: String
    public let category: String
    fileprivate let logger: OSLog
    fileprivate let syncQueue = DispatchQueue(label: "com.leakka.logger")
    
    public required init(subsystem: String, category: String = "") {
        self.subsystem = subsystem
        self.category = category
        self.logger = OSLog(subsystem: subsystem, category: category) //ios10
    }
    
    public func log(_ message: String, type: OSLogType, file: String, function: String, line: Int) {
        syncQueue.sync { //protect logger from concurrent access
            os_log("%@ [%@ %@ line%d] %@", log: logger, type: type, type.description, file, function, line, message)
        }
    }
}

// The FlyweightLoggerFactory ensures the Flyweight behavior: the same logger instance for given key
// key  returned for a particular identifier (subsystem + category pair)
public class FlyweightLoggerFactory {
    fileprivate var loggersByID = Dictionary<String, FlyweightLogger>()
    fileprivate let syncQueue = DispatchQueue(label: "com.leakka.flyweightLoggerFactory")
    
    public static var shared = FlyweightLoggerFactory() //singleton instantiation
    
    fileprivate init() {} //hide the instantiator
    
    public  func logger(subsystem: String, category: String = "") -> FlyweightLogger? {
        var result: FlyweightLogger?
        syncQueue.sync {   //protect from concurrent access
            let key = subsystem + category
            //if logger exists , return it
            if let logger = loggersByID[key] {
                result = logger
            } else {
                // otherwide crete new logger
                result = Logger(subsystem: subsystem, category: category)
                loggersByID[key] = result
            }
        }
        return result
    }
}


