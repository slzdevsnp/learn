//
//  BuyTicketsOperation.h
//  TicketSim
//
//  Created by Sviatoslav Zimine on 10/30/17.
//  Copyright © 2017 Brice Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Simulator.h"
#import "SimulationResult.h"


@protocol BuyTicketsDelegate <NSObject>
- (void)displayBuyticketsResult:(SimulationResult *)result;
@end

@interface BuyTicketsOperation : NSOperation

-(id)initWithCustomerName:(NSString *)name;

@property NSString *customerName;
@property id<BuyTicketsDelegate> delegate;

@end
