//
//  ComputerFactory.swift
//  ComputerShop
//
//  Created by Sviatoslav Zimine on 9/24/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import UIKit

public enum ComputerType {
    case basic
    case office
    case developer
    case highEnd
}

public class ComputerFactory {
    
    //functions to create related objects
    public func makeFinish() ->Finish? {
        return nil
    }
    public func makeStorage() -> Storage?{
        return nil
    }
    public func makeProcessor() -> Processor?{
        return nil
    }
    public func makeMemory() -> Memory?{
        return nil
    }
    //method is final to prevent it overriding
    public final class func makeFactory(type: ComputerType ) -> ComputerFactory {
        var factory: ComputerFactory
        switch(type) {
            case .basic:
                factory = BasicComputerFactory()
            case .office:
                factory = OfficeComputerFactory()
            case .developer:
                factory = DeveloperComputerFactory()
            case .highEnd:
                    factory = HighEndComputerFactory()
        }
        return factory
    }
}

//a subclass for a basic computer type factory, not visible outside their source file
fileprivate class BasicComputerFactory: ComputerFactory{
    
    override func makeFinish() -> Finish? {
        return WhiteFinish()
    }
    override func makeStorage() -> Storage? {
        return SmallHardDisk()
    }
    override func makeProcessor() -> Processor? {
        return BasicProcessor()
    }
    override func makeMemory() -> Memory? {
        return BasicMemory()
    }
}
fileprivate class OfficeComputerFactory: ComputerFactory {
    override func makeFinish() -> Finish? {
        return WhiteFinish()
    }
    override func makeStorage() -> Storage? {
        return MediumHardDisk()
    }
    override func makeProcessor() -> Processor? {
        return FastProcessor()
    }
    override func makeMemory() -> Memory? {
        return AdvancedMemory()
    }
}

fileprivate class DeveloperComputerFactory: ComputerFactory {
    override func makeFinish() -> Finish? {
        return WhiteFinish()
    }
    
    override func makeStorage() -> Storage? {
        return MediumFlash()
    }
    
    override func makeProcessor() -> Processor? {
        return TurboProcessor()
    }
    
    override func makeMemory() -> Memory? {
        return ProMemory()
    }
}

fileprivate class HighEndComputerFactory: ComputerFactory {
    override func makeFinish() -> Finish? {
        return BlackFinish()
    }
    
    override func makeStorage() -> Storage? {
        return HugeFlash()
    }
    
    override func makeProcessor() -> Processor? {
        return HighEndProcessor()
    }
    
    override func makeMemory() -> Memory? {
        return ProMemory()
    }
}
