//
//  EnhancedThreadSafeSessionState.swift
//  EnhancedEnhancedThreadSafeSessionState
//
//  Created by Nyisztor, Karoly on 2016. 09. 27..
//  Copyright © 2016. Nyisztor, Karoly. All rights reserved.
//

import Foundation

/// Singleton EnhancedThreadSafeSessionState class
/// Declared as final to prevent subclassing - not even withon this file
final public class EnhancedThreadSafeSessionState {
    /// hidden initializer
    private init() {}
    
    /// in-memory storage for key-value pairs
    private var storage = [String:Any?]()
    
    /// Async queue using a barrier to ensure a reader/writer lock
    private let asyncQueue = DispatchQueue(label: "asyncQueue", attributes: .concurrent, target: nil)
    
    /// Swift guarantees that lazily intialized globals or static properties are thread-safe
    /// GCD dispatch_once is no longer available in Swift and there is no need for it either
    public static let sharedInstance: EnhancedThreadSafeSessionState = {
        let instance = EnhancedThreadSafeSessionState()
        return instance
    }()
    
    
    /// Stores a value in our in-memory hashmap
    /// Uses generics to avoid casting when retrieving values (no need to use "as? Type")
    /// - parameter value: value to be stored; pass nil to remove the original value
    /// - parameter key:   unique key
    public func set<T>( _ value: T?, forKey key: String ) {
        // improved version using a barrier, which won't block the caller thread
        //
        // The barrier ensures that the queue won't start executing the block
        // until all the previous blocks have completed - so that we cannot have race conditions
        // and data corruption due to concurrent writing and reading
        //
        // Read access happens in ordinary blocks, whereas write happens in barrier blocks
        // GCD won't process the barrier block until all pending read operations complete.
        //
        // The barrier changes the concurrent queue into a serial queue for s long as it takes 
        // to process the barrier block, after which it reverts to a concurrent queue again
        //
        // Barriers are a perfect choice for reader/writer locks
        asyncQueue.async( flags: .barrier ) {
            if value == nil {
                if self.storage.removeValue(forKey: key) != nil {
                    print("Successfully removed value for key \(key)")
                } else {
                    print("No value for key \(key)")
                }
            }
            self.storage[key] = value
        }
    }
    
    
    /// Retrieves a value given its unique key
    ///
    /// - parameter key: unique key
    ///
    /// - returns: value for given key; can be nil
    public func object<T>( forKey key: String ) -> T? {
        var result: T? = nil
        // synchronized access
        asyncQueue.sync {
            result = self.storage[key] as? T
        }
        return result
    }
}
