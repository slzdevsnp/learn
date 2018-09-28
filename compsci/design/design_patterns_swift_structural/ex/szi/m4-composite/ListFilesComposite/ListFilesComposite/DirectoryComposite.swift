//
//  DirectoryComposite.swift
//  ListFilesComposite
//
//  Created by Sviatoslav Zimine on 9/24/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import Foundation

// We introduce a common, FileSystemEntry protocol and make our types conform to it
// The common protocol lets us remove the type checks
public protocol FileSystemEntry: CustomStringConvertible {
    init(name: String)
    func nesting(level: Int)
    var size: UInt32 {get}
}

public class CFile: FileSystemEntry {
    
    fileprivate var nestingLevel: Int = 0
    fileprivate let name: String
    
    public func nesting(level: Int) {
        self.nestingLevel = level
    }
    
    public required init(name: String) {
        self.name = name
    }
    
    public var description: String {
        let nesting = String(repeating: "\t", count: nestingLevel) + "- "
        return "\(nesting)\(name) (" + String(format: "%.1f", (Float(size)/1024/1024)) + "MB)"
    }
    
    lazy public var size = arc4random_uniform(1000000)
}

public class CDirectory: FileSystemEntry {
    fileprivate var entries = Array<FileSystemEntry>()
    fileprivate var nestingLevel: Int = 0
    fileprivate let name: String
    
    public func nesting(level: Int) {
        self.nestingLevel = level
    }
    
    public required init(name: String) {
        self.name = name
    }
    
    public func add( entry: FileSystemEntry) {
        entry.nesting(level: self.nestingLevel + 1)  // all the type checking code is gone
        entries.append(entry)
    }
    
    public var description: String {
        var result = String(repeating: "\t", count: nestingLevel) + "[+] \(name) (" + String(format: "%.1f", (Float(size)/1024/1024)) + "MB)"
        
        for entry in self.entries {
            result += "\n\(entry)"
        }
        return result
    }
    
    public var size: UInt32 {
        var result: UInt32 = 0
        
        for entry in self.entries {
            result += entry.size
        }
        return result
    }
}
