//
//  main.m
//  PrimitivesStructArrays
//
//  Created by Sviatoslav Zimine on 10/26/17.
//  Copyright © 2017 Sviatoslav Zimine. All rights reserved.
//

#import <Foundation/Foundation.h>

//extend  the NSDate
@interface NSDate (BensDateJuice)
+ (NSDate *)tomorrow;
@end

@implementation NSDate (BensDateJuice)
+ (NSDate *)tomorrow{
    NSDate *today = [NSDate date];
    NSDate *tomorow =  [today dateByAddingTimeInterval: 60*60*24];
    return tomorow;
}
@end

void printHeader(NSString *label){
    NSLog(@"");
    NSLog(@"##############################");
    NSLog(@"##");
    NSLog(@"##\t%@",label);
    NSLog(@"##");
    NSLog(@"################################");
    NSLog(@"");
}

void demoNSString(){
    char *classicc = "Bernard";
    NSString *pretty = @"BenB";
    NSString *prettybis = @"PowerToYou";
    
    //how to replace a substring in NSString
    pretty = [pretty stringByReplacingOccurrencesOfString:@"B"    withString:@"Z"];
    //replace a substring on a index range
    prettybis = [prettybis stringByReplacingCharactersInRange:NSMakeRange(0, 3) withString:@"Flow"];
    
    //uppper case
    NSString *wantUpperCased = @"ben";
    wantUpperCased = [ wantUpperCased capitalizedString];
    
    NSLog(@"hello, World! %@ %s",pretty,classicc); //%s is used for c-string
    NSLog(@"%@",prettybis);
    NSLog(@"%@",wantUpperCased);
    
    // matching a substring
    NSString *benny = @"Ben is a groovy guy";
    benny = [benny capitalizedString];  //capitalize each word in  the string
    NSRange  range = [benny rangeOfString:@"Groovy"];
    
    if ( range.length > 0){
        NSLog(@"Ben's Groov!");
    }else{
        NSLog(@"Ben's NOT Groov!");
    }
    
    //extracting a a substream
    NSString *subString = [benny substringFromIndex:6];
    NSString *subStringB = [benny substringWithRange:NSMakeRange(8, 11)];
    NSLog(@"%@",subString);
    NSLog(@"%@:",subStringB);
    
    //extracting a substring with a regexp
    NSString *poshy = @"Ben is a groovy guy";
    NSRegularExpression *regex = [ NSRegularExpression regularExpressionWithPattern:@"Ben is a (.*)$" options:NSRegularExpressionCaseInsensitive | NSRegularExpressionUseUnixLineSeparators error:nil ]; //would match full str
    
    NSArray *matches = [regex matchesInString:poshy options:0 range:NSMakeRange(0, [poshy length])];
    int i  = 0;
    for ( NSTextCheckingResult *result in matches){
        NSLog(@"regex: %@", NSStringFromRange([result range]));  //shows result matches the whole string
        if ( result.numberOfRanges > 1){
            NSLog(@"%d : range: %@", i,NSStringFromRange([result rangeAtIndex:1]));
            NSLog(@"%d: regx result: %@", i,[poshy substringWithRange:[result rangeAtIndex:1]]); // 2nd match
        }
        i++;
    }

    
}

void  demoNumbers(){
    
    //declare a classinc int
    int x = 5;  //c code
    
    NSLog(@"a usual int: %d",x);
    
    //object type of numbers
    NSNumber *y = [NSNumber numberWithInt:55 ] ; //boxing
    NSLog(@"objc num type: %@",y);
    
    
    //double
    double pi = 3.14567;
    NSLog(@"a usual double: %f",pi);
    
    CGFloat z = 250.33f;  // CGFloat is an alias of float or double depending of OS
    NSLog(@"a cgfloat: %f",z);
    
    NSNumber *pow = [NSNumber numberWithDouble:2.71345 ] ; //boxing
    NSLog(@"objc num type with double : %@",pow);
    
    
    //Decimal is 128 - type using base-10 calculation.  important for calculation with precision
    NSDecimalNumber  *one = [ NSDecimalNumber one];
    NSLog(@"NSDecimal: %@",one);
    
    NSDecimalNumber  *fortyTwo = [ NSDecimalNumber  decimalNumberWithString:@"42.0"];
    NSDecimalNumber *sum = [ one decimalNumberByAdding:fortyTwo];
    NSLog(@"NSDecimal sum: %@",sum);
    
    //example  decimal math operations using  NSDecimal type  accumulator anmd temp
    NSDecimal accumulator = [sum decimalValue];  // NSDecimal is a struct
    NSDecimal temp = [fortyTwo decimalValue];
    NSDecimalMultiply(&accumulator, &accumulator, &temp, NSRoundPlain);
    temp = [one decimalValue];
    NSDecimalAdd(&accumulator, &accumulator, &temp,NSRoundPlain);
    NSDecimalNumber *result = [NSDecimalNumber decimalNumberWithDecimal: accumulator];
    NSLog(@"NSDecimal accumulator: %@",result);
    
}

void demoDates(){
    NSDate *today = [NSDate date];
    NSDate *tomorow =  [today dateByAddingTimeInterval: 60*60*24]; // interval measured in seconds
    
    // allocate memory for a new object instance and initialize the object
    NSDateFormatter  *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle: NSDateFormatterLongStyle]; // with styles
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    
    NSLog(@"today: %@", [formatter stringFromDate:today] );
    NSLog(@"tommorow: %@", [formatter stringFromDate:tomorow] );

    NSDate *tomorrowBis = [NSDate tomorrow]; //by using the implemented method in extension

    NSLog(@"tommorow again: %@", [formatter stringFromDate:tomorrowBis] );

    //set date format in formatter
    [formatter setDateFormat:@"MM-dd-yyyy::HH:mm:SS"]; // date and time format
    NSLog(@"custom formatted today: %@", [formatter stringFromDate:today] );

    //create date from a string
    NSString *someDate = @"04/10/2012";
    [formatter setDateFormat:@"MM/dd/yyyy"] ;
    NSDate *customDate = [formatter dateFromString:someDate ];

    NSLog(@"custom date from string: %@", [formatter stringFromDate:customDate] );

}

void demoArrays(){
    
    //arrays are not mutable
    NSArray *favoriteTwitterPeople = [NSArray arrayWithObjects:@"@shanselman",
                                                              @"@subdigital",
                                                              @"@texas",
                                                              nil ]; // id == swift's Any
    
    //classic c loop
    for (  int i = 0; i < [favoriteTwitterPeople count]; i++){
        NSLog(@"arr el: %@", [favoriteTwitterPeople objectAtIndex:i] );
        //NSLog(@"arr el: %@", favoriteTwitterPeople[i] ); //also works
    }
    //loop with enumeration
    
    for ( NSString *peep in favoriteTwitterPeople){ //we know this is an array of strigs
        int idx = [favoriteTwitterPeople indexOfObject:peep ];
        NSLog(@"looping: at: %d %@", idx,peep );
    }
    //loop with enumerate using a block
    [favoriteTwitterPeople enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        //this scope is a block
        NSLog(@"iterator: %@", obj );
    }];
}

void demoDictionary(){
    
    NSDictionary *beers = [ NSDictionary dictionaryWithObjectsAndKeys:
                           @"Racer 5"       ,@"Bear Republic",
                           @"Golden Monkey" ,@"Victory",
                           nil];
    
    for(NSString *key in [beers allKeys ]  ){
        NSLog(@"dict: for key: %@  value is: %@" , key, [beers objectForKey:key] );
    }
    
    NSEnumerator *en = [beers keyEnumerator];
    id obj = [ en nextObject];
    while ( obj  ){
        NSLog(@"enumerator: the key: %@. The value is: %@" , obj, [beers objectForKey:obj] );
        obj = [en nextObject];
    }
    
}

void demoSet(){
    NSSet *badGuys = [NSSet setWithObjects:@"@shanselman",@"@vader", @"@me", nil ];
    for (NSString *badGuy in [badGuys allObjects]){
        NSLog(@"%@", badGuy);
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        printHeader(@"demo  NSString");
        demoNSString();
        
        printHeader(@"demo Numbers in objc");
        demoNumbers();
 
        printHeader(@"demo Dates in objc");
        demoDates();
        
        printHeader(@"demo Arrays in objc");
        demoArrays();

        printHeader(@"demo Dictionary in objc");
        demoDictionary();

        printHeader(@"demo Set in objc");
        demoSet();

        
    }
    return 0;
}
