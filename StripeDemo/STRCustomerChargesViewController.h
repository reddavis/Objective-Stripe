//
//  STRCustomerChargesViewController.h
//  StripeDemo
//
//  Created by Red Davis on 25/08/2012.
//  Copyright (c) 2012 Red Davis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STRCustomer;


@interface STRCustomerChargesViewController : UITableViewController

@property (strong, nonatomic) STRCustomer *customer;

@end
