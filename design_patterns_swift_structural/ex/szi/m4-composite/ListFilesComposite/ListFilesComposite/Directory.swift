//
//  Directory.swift
//  ListFilesComposite
//
//  Created by Sviatoslav Zimine on 9/24/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import Foundation

public class File: CustomStringConvertible {
    
    fileprivate var nestingLevel: Int = 0
    fileprivate let name: String
    
    public func nesting(level: Int) {
        self.nestingLevel = level
    }
    
    public init(name: String) {
        self.name = name
    }
    
    public var description: String {
        let nesting = String(repeating: "\t", count: nestingLevel) + "- "
        return "\(nesting)\(name) (" + String(format: "%.1f", (Float(size)/1024/1024)) + "MB)"
    }
    // generate a random file size
    lazy public var size = arc4random_uniform(1000000)
}

public class Directory: CustomStringConvertible {
    fileprivate var entries = Array<AnyObject>()
    fileprivate var nestingLevel: Int = 0
    fileprivate let name: String
    
    public func nesting(level: Int) {
        self.nestingLevel = level
    }
    
    public required init(name: String) {
        self.name = name
    }
    // Directories contain entries, each of which could be a File or another Directory
    // We must check whether it's a Directory or a File whenever we access an entry
    public func add( entry: AnyObject) {
        if let fileEntry = entry as? File {
            fileEntry.nesting(level: self.nestingLevel + 1)
        } else if let directoryEntry = entry as? Directory {
            directoryEntry.nesting(level: self.nestingLevel + 1)
        }
        
        entries.append(entry)
    }
    
    public var description: String {
        var result = String(repeating: "\t", count: nestingLevel) + "[+] \(name) (" + String(format: "%.1f", (Float(size)/1024/1024)) + "MB)"
        
        
        for entry in self.entries {
            if let fileEntry = entry as? File {  //!! we need to check the type of files whenever we access it
                result += "\n\(fileEntry)"
            } else if let directoryEntry = entry as? Directory {
                result += "\n\(directoryEntry)"
            }
        }
        return result
    }
    
    public var size: UInt32 {
        var result: UInt32 = 0
        
        for entry in self.entries {
            if let fileEntry = entry as? File {
                result += fileEntry.size
            } else if let directoryEntry = entry as? Directory {
                result += directoryEntry.size
            }
        }
        return result
    }
}
