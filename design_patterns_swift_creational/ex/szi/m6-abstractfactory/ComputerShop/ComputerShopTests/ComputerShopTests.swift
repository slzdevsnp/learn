//
//  ComputerShopTests.swift
//  ComputerShopTests
//
//  Created by Sviatoslav Zimine on 9/24/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import XCTest
@testable import ComputerShop

class ComputerShopTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    private func printXCTestHeader(_ label: String) {
        print("\n*************************************************")
        print("*  \(label)")
        print("**************************************************\n")

    }
    func testCreateComputerConfigsWithNoFactory() {
       printXCTestHeader("testCreateComputerConfigsWithNoFactory")
        
        //issue here we expose a lot of our implementation details
        let basicComputer = Computer(finish: WhiteFinish(),
                                     storage: SmallHardDisk(),
                                     processor: BasicProcessor(),
                                     memory: BasicMemory() )
        
        print(basicComputer)
        
        let officeComputer = Computer(finish: WhiteFinish(),
                                         storage: MediumFlash(),
                                         processor: FastProcessor(),
                                         memory: AdvancedMemory() )
            
        print(officeComputer)

            
            
        XCTAssertEqual(basicComputer.price, 1250.0 , "basic computer price unexpected")
        XCTAssertEqual(officeComputer.finish.color, UIColor.white , "office computer finish unexpected")

    }

    func testCreateComputerConfigWithAbstractFactory(){
        printXCTestHeader("testCreateComputerConfigWithAbstractFactory")
        
        //details of basic computer are not exposed
        let basicComputerFactory = ComputerFactory.makeFactory(type: .basic)
        if let finish = basicComputerFactory.makeFinish(),
            let storage = basicComputerFactory.makeStorage(),
            let processor = basicComputerFactory.makeProcessor(),
            let memory = basicComputerFactory.makeMemory(){
            
            //obseve how computer details are not exposed
            let computer = Computer(finish: finish,storage: storage, processor: processor, memory: memory)
            print(computer)

            XCTAssertEqual(computer.price, 1250.0 , "basic computer price unexpected")
        }

        let highendComputerFactory = ComputerFactory.makeFactory(type: .highEnd)
        if let finish = highendComputerFactory.makeFinish(),
            let storage = highendComputerFactory.makeStorage(),
            let processor = highendComputerFactory.makeProcessor(),
            let memory = highendComputerFactory.makeMemory(){
            
            //obseve how computer details are not exposed
            let computer = Computer(finish: finish,storage: storage, processor: processor, memory: memory)
            print(computer)
            
            XCTAssertEqual(computer.finish.color, UIColor.black , "highend computer finish unexpected")
        }

    }
}
