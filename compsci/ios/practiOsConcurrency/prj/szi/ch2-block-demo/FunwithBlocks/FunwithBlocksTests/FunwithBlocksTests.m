//
//  FunwithBlocksTests.m
//  FunwithBlocksTests
//
//  Created by Sviatoslav Zimine on 10/29/17.
//  Copyright © 2017 Sviatoslav Zimine. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface FunwithBlocksTests : XCTestCase

@end

@implementation FunwithBlocksTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
