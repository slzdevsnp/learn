//
//  ViewController.m
//  TekPubMobileApp
//
//  Created by Sviatoslav Zimine on 10/26/17.
//  Copyright © 2017 Sviatoslav Zimine. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize welcomeLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) viewDidUnload
{
    [self setWelcomeLabel:nil];
    [super viewDidUnload];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)onButtonTapped:(id)sender {
    welcomeLabel.text = [NSString stringWithFormat:@"Hello from TEKPub"];
    [UIView animateWithDuration:1.0 animations:^{     // this is a closure
        self.view.backgroundColor = [ UIColor redColor];
        welcomeLabel.frame = CGRectMake(0, 0, 200, 50);
    }];
}


- (void)dealloc {
    [welcomeLabel release];
    [super dealloc];
}
@end
