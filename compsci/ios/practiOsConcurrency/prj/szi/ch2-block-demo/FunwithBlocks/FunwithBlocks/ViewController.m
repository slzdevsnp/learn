//
//  ViewController.m
//  FunwithBlocks
//
//  Created by Sviatoslav Zimine on 10/29/17.
//  Copyright © 2017 Sviatoslav Zimine. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

typedef  int  (^IntBlock)(int); //type alias



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self declareAndCallBlock];
    
    [self shareScopeVars];
    
    [self useInlineBlock];
}



-(void) declareAndCallBlock {
    IntBlock  squareBlock = ^(int num) { //return value is automatically determined
        return num * num;
    };
    NSLog(@"block return value %d", squareBlock(3));
}


-(void) shareScopeVars {
    __block NSString *weather = @"Rainy"; //make a variables modifiable inside  the block
    NSLog(@"Weather before block: %@", weather);
    
    //declare block
    void (^changeWeatcher)(void) = ^{
        weather = @"Sunny";
        NSLog(@"Weather inside block: %@", weather);
    };
    changeWeatcher();
    NSLog(@"Weather after block: %@", weather);

}


-(void)useInlineBlock{
    
    __block int counter = 0;
    __block NSString *feed  = @"";
    NSArray *names = [NSArray arrayWithObjects:@"Desai", @"Tolstoy", @"Austen",@"Hemingway",@"Dickens",nil];
    [ names enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        NSString *person = (NSString *) obj;
        NSLog(@"Name: %@",[person uppercaseString]);
        counter++;
        feed = [[feed stringByAppendingString:[person uppercaseString]] stringByAppendingString:@" "];
    }];
    NSLog(@"names counter after block: %d",counter);
    NSLog(@"feed after block:%@",feed);

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
