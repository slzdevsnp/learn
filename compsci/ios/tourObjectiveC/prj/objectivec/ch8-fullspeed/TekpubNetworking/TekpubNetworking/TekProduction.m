//
//  TekProduction.m
//  TekpubNetworking
//
//  Created by Sviatoslav Zimine on 10/29/17.
//  Copyright © 2017 Sviatoslav Zimine. All rights reserved.
//

#import "TekProduction.h"

@implementation TekProduction

@synthesize fname = _fname;  //to avoid naming collisions with method names
@synthesize lname = _lname;
@synthesize email = _email;


-(id) initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self){
        _fname = [dictionary objectForKey:@"first_name"];
        _lname = [dictionary objectForKey:@"last_name"];
        _email = [dictionary objectForKey:@"email"];

    }
    return self;
}

@end
