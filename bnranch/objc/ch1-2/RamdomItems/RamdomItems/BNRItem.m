//
//  BNRItem.m
//  RamdomItems
//
//  Created by Sviatoslav Zimine on 5/16/17.
//  Copyright © 2017 szimine. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem


+ (instancetype) randomItem
{
	NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
	NSArray *randomNountList = @[@"Bear", @"Spork", @"Mac"];

	//get random int between [0 and 2] inclusive
	// NSInteger = type definition for long
	NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
	NSInteger nounIndex = arc4random() % [randomNountList count];

	NSString *randomName = [NSString stringWithFormat:@"%@ %@",
							[randomAdjectiveList objectAtIndex:adjectiveIndex],
							[randomNountList objectAtIndex:nounIndex]] ;

	int randomValue = arc4random() % 100;

	NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                        '0' + arc4random() % 10,
                                        'A' + arc4random() % 26,
                                        '0' + arc4random() % 10,
                                        'A' + arc4random() % 26,
                                        '0' + arc4random() % 10];

	BNRItem *newItem = [[self alloc] initWithItemName:randomName 
										valueInDollars:randomValue
										serialNumber:randomSerialNumber];
    return newItem;
}


- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                  serialNumber:(NSString *)serialNumber
{
    self = [super init] ;

    if (self){
    	_itemName = name; 
    	_serialNumber = serialNumber; 
    	_valueInDollars = value;
    	_dateCreated = [[NSDate alloc]init];
	    
    }
    return self;
}

- (instancetype) initWithItemName:(NSString *)name
{
    return [self initWithItemName:name
                   valueInDollars:0
                     serialNumber:@""];
}

//override of init
- (instancetype) init
{
    return [ self initWithItemName:@"Item"] ;
}


- (void) setItemName:(NSString *)str
{
	_itemName = str;
}

- (NSString *)itemName
{
	return _itemName;
}

- (void)setSerialNumber:(NSString *)str
{
	_serialNumber = str;
}

-(NSString *)serialNumber
{
	return _serialNumber;
}

- (void)setValueInDollars:(int)v
{
	_valueInDollars = v;
}

- (int)valueInDollars
{
	return _valueInDollars;
}

-(NSDate *)dateCreated
{
	return _dateCreated;
}

//override from supercalss
- (NSString *)description 
{
	NSString *descrString = [[NSString alloc]
								initWithFormat:@"%@ (%@): Worth $%d recorded on %@",
								self.itemName,
								self.serialNumber,
								self.valueInDollars,
								self.dateCreated ] ;
	return descrString; 


}


@end
