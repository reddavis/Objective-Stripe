//
//  STRNewCustomerChargeViewController.m
//  StripeDemo
//
//  Created by Red Davis on 25/08/2012.
//  Copyright (c) 2012 Red Davis. All rights reserved.
//

#import "STRNewCustomerChargeViewController.h"
#import "STRCustomer.h"
#import "STRStripeHTTPClient.h"


@interface STRNewCustomerChargeViewController ()

@end


@implementation STRNewCustomerChargeViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Create Charge";
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self.navigationController action:@selector(dismissModalViewControllerAnimated:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions

- (void)createButtonTapped:(id)sender {
    
    NSNumber *amount = [NSNumber numberWithFloat:self.amountTextField.text.floatValue*100];
    
    STRStripeHTTPClient *client = [STRStripeHTTPClient sharedClient];
    [client createCharge:amount forCustomerWithID:self.customer.identifier details:self.descriptionTextField.text success:^(STRCharge *charge) {
       
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Charge was successfully created" delegate:nil cancelButtonTitle:@"Cool" otherButtonTitles:nil];
        
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            [alert show];
        }];
    } failure:^(NSError *error) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uh-Oh!" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
}

@end
