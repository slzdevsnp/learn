//
//  TekProduction.h
//  TekpubNetworking
//
//  Created by Sviatoslav Zimine on 10/29/17.
//  Copyright © 2017 Sviatoslav Zimine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TekProduction : NSObject

- (id)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy) NSString *fname;
@property (nonatomic, copy) NSString *lname;
@property (nonatomic, copy) NSString *email;

@end
