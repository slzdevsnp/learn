//
//  AppDelegate.m
//  TekpubData
//
//  Created by Sviatoslav Zimine on 10/27/17.
//  Copyright © 2017 Sviatoslav Zimine. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //get tthe document directory
    NSString *documentsDirectory = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    NSString *targetPath = [ documentsDirectory stringByAppendingPathComponent:@"northwind.db"];
    
    //conditionally copy the db from the bundle to the device FS
    if(![[NSFileManager defaultManager] fileExistsAtPath:targetPath]){
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"northwind" ofType:@"db"];
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:targetPath error:nil ];
    }

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // create an instance of the view controller you want to be displayed first
    ViewController *viewController = [[ViewController alloc] initWithNibName:@"MainView" bundle:nil];
    // set it as the root view controller of the application's window
    [self.window setRootViewController:viewController];
    
    self.window.backgroundColor = [UIColor lightGrayColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
