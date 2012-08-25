//
//  STRNewCustomerChargeViewController.h
//  StripeDemo
//
//  Created by Red Davis on 25/08/2012.
//  Copyright (c) 2012 Red Davis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STRCustomer;


@interface STRNewCustomerChargeViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) STRCustomer *customer;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIButton *createChargeButton;

- (IBAction)createButtonTapped:(id)sender;

@end
