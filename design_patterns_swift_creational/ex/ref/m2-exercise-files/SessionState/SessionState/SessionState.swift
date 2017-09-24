//
//  SessionState.swift
//  SessionState
//

import Foundation

public class SessionState {

    /// In-memory storage for key-value pairs
    private var storage = [String: Any]()
    
    /// Hide initializer
    private init() {}
    
    /// Swift guarantees that lazily initialized globals or static properties are thread-safe
    /// GCD dispatch_once is not needed to create singletons, 
    /// and it is no longer available in Swift 3
    public static let shared: SessionState = {
        let instance = SessionState()
        return instance
    }()
    
    public func set( _ value: Any, forKey key: String) {
        storage[key] = value
    }
    
    public func object( forKey key: String ) -> Any? {
        return storage[key] ?? nil
    }
}
