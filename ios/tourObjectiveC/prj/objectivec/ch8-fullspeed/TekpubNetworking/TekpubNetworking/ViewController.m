//
//  ViewController.m
//  TekpubNetworking
//
//  Created by Sviatoslav Zimine on 10/29/17.
//  Copyright © 2017 Sviatoslav Zimine. All rights reserved.
//

#import "ViewController.h"
#import "TekProduction.h"

@interface ViewController ()

@property (nonatomic, copy) NSArray *entries;

@end

@implementation ViewController

@synthesize tableView = _tableView;
@synthesize entries = _entries;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadProductions];
    
    
}

-(void) viewDidUnload {
    [super viewDidUnload];
    self.tableView  = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

//network response


// for TableViewController
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.entries.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
    if (!cell) {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:cellIdentifier];
    }
    TekProduction *tp = [self.entries objectAtIndex:indexPath.row ];
    
    cell.textLabel.text  = [NSString  stringWithFormat:@"Cell %d", indexPath.row];
    
    cell.textLabel.text = [[tp.fname stringByAppendingString:@" "]
                               stringByAppendingString:tp.lname];
    cell.detailTextLabel.text = tp.email;
    
    return cell;
}

- (void)loadProductions {
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/rest_glassfish_hello_war_exploded/hellojson"];
    NSURLRequest *request = [NSURLRequest  requestWithURL:url];
    
    //start network loading
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *err) {
           @try{
               if (err != nil){
                   NSLog(@"%@",[err localizedDescription]  );
               }
               NSHTTPURLResponse *httpResponse  = (NSHTTPURLResponse *)response ; //casting
               NSLog(@"http %ld",(long)[httpResponse statusCode] );
               
               if ([httpResponse statusCode] == 200  ){
                   NSString *jsonstr = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
                   NSLog(@"response %lu bytes", (long)[data length]);
                   [self parseResponse: data];
               }else {
                   [self showSimpleAlert:@"ERROR" alertMessage:@"Network Ressources unavailable" ];
               }

           }@catch(NSException *ex){
               NSLog(@"problem to access url: %@", ex);
           }
          //stop network loading
       }];
}

- (void) parseResponse: (NSData *)jsonData{
    NSError *error  = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options: NSJSONReadingAllowFragments
                                                      error: &error];
    if (error){
        NSLog(@"ERROR Parsing: %@", error);
        return;
    }

    NSLog(@"titleObject %@",[dictionary objectForKey:@"title"]);
    NSDictionary *dbdict =  [dictionary objectForKey:@"db"] ;
    NSLog(@"db n elements: %lu", (unsigned long)[dbdict count]);

    NSMutableArray *entries = [NSMutableArray array];
    for (NSDictionary *dbDictionary in [dictionary objectForKey:@"db"]){
        //NSLog(@"email %@", [dbDictionary objectForKey:@"email"] );
        TekProduction *production =  [[ TekProduction alloc] initWithDictionary:dbDictionary];
        [entries addObject:production];
    }
    self.entries = entries;
    [self.tableView reloadData ];
}





- (void) showSimpleAlert:(NSString*)title alertMessage:(NSString *)message  {
    UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:title
                                                     message:message
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil, nil];
    [alert show];
}


@end

