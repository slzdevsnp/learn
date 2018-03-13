//
//  ViewController.m
//  TekpubData
//
//  Created by Sviatoslav Zimine on 10/27/17.
//  Copyright © 2017 Sviatoslav Zimine. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"northwind" ofType:@"db"] ; //works only in simul
    NSString *documentsDirectory = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [ documentsDirectory stringByAppendingPathComponent:@"northwind.db"];
    NSLog(@"the db path: %@",path);
    FMDatabase *db = [ FMDatabase databaseWithPath:path];
 
    @try{
        if ( ![db open]){
            NSLog(@"Can't open db");
            return ;
        }
        //lets insert some records
        [db executeUpdate:@"INSERT into products(id,name,description) VALUES(?,?,?)" withArgumentsInArray:
             [NSArray arrayWithObjects:  [NSNumber numberWithInt:11],
                                          @"prod11 name",
                                          @"prod11 descr",
                                          nil ]];
        
        
        FMResultSet  *result =  [db executeQuery:@"select * from products"];
        
        while ( [result next]){
            NSLog(@"the name is %@",[result stringForColumn:@"name"]);
        }
    }@catch(NSException *ex){
        NSLog(@"db con problem");
    }@finally {
        [db close];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
