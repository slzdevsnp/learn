//
//  main.m
//  RamdomItems
//
//  Created by Sviatoslav Zimine on 5/16/17.
//  Copyright © 2017 szimine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"

int main(int argc, const char * argv[]) {

    @autoreleasepool {
    NSMutableArray *items = [[NSMutableArray alloc] init];



   BNRItem *item = [[BNRItem alloc]init];

   [item setItemName:@"Red Sofa"];
   [item setSerialNumber:@"A1B2C"];
   //[item setValueInDollars:100.99];
    item.valueInDollars = 100;  //dot notation



    NSLog(@"%@", [item description]);

    
    //with initializers
    BNRItem *item1 = [[BNRItem alloc] initWithItemName:@"Blue Rocket"
                                        valueInDollars:999
                                        serialNumber:@"A1B3D"] ;
    

    NSLog(@"%@", [item1 description]);

    
    ///// array of items
    
    int itemLength = 10;
    for (int i = 0 ; i < itemLength; i++){
        BNRItem *item = [BNRItem randomItem];
        [items addObject:item];
    }


    
    for (BNRItem *item in items ){
        NSLog(@"%@", item);
    }
    
    
    //destroy mutable array
    items = nil;


    }

    return 0;
}
