//
//  STRAppDelegate.m
//  StripeDemo
//
//  Created by Red Davis on 25/08/2012.
//  Copyright (c) 2012 Red Davis. All rights reserved.
//

#import "STRAppDelegate.h"
#import "STRStripeHTTPClient.h"
#import "STRCustomersViewController.h"


@implementation STRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSURL *stripeKeyURL = [[NSBundle mainBundle] URLForResource:@"StripePublishableKey" withExtension:nil];
    
    NSError *readingKeyError = nil;
    NSString *stripKey = [NSString stringWithContentsOfURL:stripeKeyURL encoding:NSUTF8StringEncoding error:&readingKeyError];
    
    if (readingKeyError) {
        NSLog(@"Error reading Stripe Key %@", readingKeyError);
    }
    else {
        [STRStripeHTTPClient setAPIKey:stripKey];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.tabBarController = [[UITabBarController alloc] init];
    
    STRCustomersViewController *customersViewController = [[STRCustomersViewController alloc] initWithNibName:@"STRCustomersViewController" bundle:nil];
    UINavigationController *customersNavigationController = [[UINavigationController alloc] initWithRootViewController:customersViewController];
    
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:customersNavigationController, nil];
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
        
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
