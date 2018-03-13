//
//  BNRItem.h
//  RamdomItems
//
//  Created by Sviatoslav Zimine on 5/16/17.
//  Copyright © 2017 szimine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject
{

	NSString *_itemName;
	NSString *_serialNumber;
	int _valueInDollars;
	NSDate *_dateCreated;

}

//class method
+ (instancetype) randomItem;

// designated initializer
- (instancetype)initWithItemName:(NSString *)name
                                valueInDollars:(int)value
                                serialNumber:(NSString *)sNumber;

- (instancetype)initWithItemName:(NSString *)name;


- (void) setItemName:(NSString *)str;
- (NSString *)itemName ;

- (void)setSerialNumber :(NSString *)str;
-(NSString *)serialNumber;

- (void)setValueInDollars:(int)v;
-(int)valueInDollars ;

-(NSDate *)dateCreated;

@end
