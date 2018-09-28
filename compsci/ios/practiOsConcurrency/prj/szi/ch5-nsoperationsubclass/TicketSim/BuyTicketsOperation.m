//
//  BuyTicketsOperation.m
//  TicketSim
//
//  Created by Sviatoslav Zimine on 10/30/17.
//  Copyright © 2017 Brice Wilson. All rights reserved.
//

#import "BuyTicketsOperation.h"

@implementation BuyTicketsOperation

-(id)initWithCustomerName:(NSString *)name {
    if (self = [super init]){
        [self setCustomerName:name];
    }
    return self;
}


-(void) main {
    
    double totalTime = 0.0;
    for (int i = 0; i < 3 ; i++){  //cancellation support
        if ([self isCancelled]){
            return;
        }
        totalTime += [Simulator runSimulationWithMinTime:1 maxTime:3];
    }
    
    SimulationResult *result =  [[SimulationResult alloc] init];
    [result setCustomerName:self.customerName];
    [result setSimulationTime:totalTime];

    [ (NSObject *)self.delegate performSelectorOnMainThread:@selector (displayBuyticketsResult:) withObject:result waitUntilDone:NO ];


}


@end
