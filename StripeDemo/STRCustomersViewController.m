//
//  STRCustomersViewController.m
//  StripeDemo
//
//  Created by Red Davis on 25/08/2012.
//  Copyright (c) 2012 Red Davis. All rights reserved.
//

#import "STRCustomersViewController.h"
#import "STRStripeHTTPClient.h"
#import "STRCustomer.h"
#import "STRLoadingView.h"
#import "STRCustomerChargesViewController.h"


@interface STRCustomersViewController ()

@property (strong, nonatomic) NSArray *customers;

- (void)fetchCustomerData;

@end


@implementation STRCustomersViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Customers";
    self.customers = [NSArray array];
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self fetchCustomerData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - 

- (void)fetchCustomerData {
    
    STRLoadingView *loadingView = [[STRLoadingView alloc] initWithFrame:self.tableView.frame];
    [self.tableView addSubview:loadingView];
    
    STRStripeHTTPClient *stripeClient = [STRStripeHTTPClient sharedClient];
    [stripeClient fetchAllCustomers:^(NSArray *customers) {
        
        self.customers = customers;
        [self.tableView reloadData]; 
        [loadingView removeFromSuperview];        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.customers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    STRCustomer *customer = [self.customers objectAtIndex:indexPath.row];
    cell.textLabel.text = customer.email;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    STRCustomerChargesViewController *customerChargesViewController = [[STRCustomerChargesViewController alloc] initWithNibName:@"STRCustomerChargesViewController" bundle:nil];
    customerChargesViewController.customer = [self.customers objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:customerChargesViewController animated:YES];
}

@end
