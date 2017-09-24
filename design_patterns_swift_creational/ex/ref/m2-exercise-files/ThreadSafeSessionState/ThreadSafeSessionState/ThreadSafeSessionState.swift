//
//  ThreadSafeSessionState.swift
//  ThreadSafeSessionState
//

import Foundation

/// Singleton ThreadSafeSessionState class
public class ThreadSafeSessionState {
    /// hidden initializer
    private init() {}
    
    /// in-memory storage for key-value pairs
    private var storage = [String:Any]()
    
    /// Serializes access to our internal dictionary
    private let syncQueue = DispatchQueue(label: "serializationQueue")
    
    /// Swift guarantees that lazily initialized globals or static properties are thread-safe
    /// GCD dispatch_once is not needed to create singletons,
    /// and it is no longer available in Swift 3
    public static let shared: ThreadSafeSessionState = {
        let instance = ThreadSafeSessionState()
        return instance
    }()
    
    public func set( _ value: Any, forKey key: String ) {
        // synchronized access
        syncQueue.sync {
            storage[key] = value
        }
    }
    
    public func object( forKey key: String ) -> Any? {
        var result: Any?
        // synchronized access
        syncQueue.sync {
            result = storage[key] ?? nil
        }
        return result
    }
}
