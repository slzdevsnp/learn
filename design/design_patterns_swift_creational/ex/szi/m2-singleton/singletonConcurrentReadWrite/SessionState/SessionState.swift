//
//  SessionState.swift
//  SessionState
//
//  Created by Sviatoslav Zimine on 9/23/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import Foundation


public class SessionState {

    //the singleton sessionState contains a dictionary of Any values
    // neither dictionaries nor arrays are thread-safe
    //concrurent access to a dictionary is a recipy to a disaster
    private var storage:[String:Any] = [:]
    
    
    //protect the singleton with Grand Central Dispatch (GCD)
    // async queue
    private let asyncQueue = DispatchQueue(label: "asyncQueue", attributes: .concurrent, target: nil)
    
    //hide the initializer
    private init() {}
    
    //shared  == threadsafe acccess
    public static let shared: SessionState = {
        let instance = SessionState()
        return instance
    }()

    //refactored to use generics
    public func set<T>(_ value: T?, forKey key: String){
        asyncQueue.async(flags: .barrier) { //async with barrier
                                            //for concurr dict mods
            if value == nil{
                if self.storage.removeValue(forKey: key) != nil {
                    print("Successfully removed value for key \(key)")
                }else{
                    print("no storage value  for key \(key)")
                }
            }
            self.storage[key] = value
        }
    }
    //refactored to use generics
    public func object<T>(forKey key: String) ->T? {
        var result: T?
        //syncronize access
        asyncQueue.sync {
            result =  storage[key] as? T  ?? nil
        }
        return result
    }
}





