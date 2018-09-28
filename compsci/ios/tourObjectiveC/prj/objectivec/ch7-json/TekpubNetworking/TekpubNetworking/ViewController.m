//
//  ViewController.m
//  TekpubNetworking
//
//  Created by Sviatoslav Zimine on 10/29/17.
//  Copyright © 2017 Sviatoslav Zimine. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void) displayMessage: (NSString *)message {
    UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:@"Hey Listen!"
                                                     message:message
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil, nil];
    [alert show];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/rest_glassfish_hello_war_exploded/hellojson"];
    NSURLRequest *request = [NSURLRequest  requestWithURL:url];
    

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
                                          completionHandler:^(NSURLResponse *response, NSData *data, NSError *err) {
          @try{
               if (err != nil){
                   NSLog(@"%@",[err localizedDescription]  );
               }
          NSHTTPURLResponse *httpResponse  = (NSHTTPURLResponse *)response ;
          NSLog(@"http %d",[httpResponse statusCode] );
          NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
          NSLog(@"response as str %@",responseString);
          //start working with json data
          NSDictionary *tekpubDict = [NSJSONSerialization JSONObjectWithData:data options: 0 error:nil];
          [self displayMessage:[tekpubDict objectForKey:@"title"] ];
    
          }@catch(NSException *ex){
              NSLog(@"problem to access url: %@", ex);
          }
   }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

