//
//  STRCustomerChargesViewController.m
//  StripeDemo
//
//  Created by Red Davis on 25/08/2012.
//  Copyright (c) 2012 Red Davis. All rights reserved.
//

#import "STRCustomerChargesViewController.h"
#import "STRStripeHTTPClient.h"
#import "STRCustomer.h"
#import "STRCharge.h"
#import "STRLoadingView.h"
#import "STRNewCustomerChargeViewController.h"


@interface STRCustomerChargesViewController ()

@property (strong, nonatomic) NSArray *charges;

- (void)fetchCharges;
- (void)createChargeButtonTapped:(id)sender;

@end


@implementation STRCustomerChargesViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"Charges for %@", self.customer.email];
    self.charges = [NSArray array];
    
    UIBarButtonItem *createChargeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createChargeButtonTapped:)];
    self.navigationItem.rightBarButtonItem = createChargeButton;
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self fetchCharges];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -

- (void)fetchCharges {
    
    STRLoadingView *loadingView = [[STRLoadingView alloc] initWithFrame:self.tableView.frame];
    [self.tableView addSubview:loadingView];
    
    STRStripeHTTPClient *stripeClient = [STRStripeHTTPClient sharedClient];
    [stripeClient fetchAllChargesForCustomerWithID:self.customer.identifier success:^(NSArray *charges) {
        
        self.charges = charges;
        [self.tableView reloadData];
        [loadingView removeFromSuperview];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Actions

- (void)createChargeButtonTapped:(id)sender {
    
    STRNewCustomerChargeViewController *newCustomerChargeViewController = [[STRNewCustomerChargeViewController alloc] initWithNibName:@"STRNewCustomerChargeViewController" bundle:nil];
    newCustomerChargeViewController.customer = self.customer;
    
    UINavigationController *newCustomerChargeNavigationController = [[UINavigationController alloc] initWithRootViewController:newCustomerChargeViewController];
    
    [self.navigationController presentModalViewController:newCustomerChargeNavigationController animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.charges.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    STRCharge *charge = [self.charges objectAtIndex:indexPath.row];
    
    NSString *labelText = charge.details;
    if (charge.refunded) {
        labelText = [labelText stringByAppendingString:@" (refunded)"];
    }
    
    cell.textLabel.text = labelText;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %.2f", charge.currency, charge.amount.floatValue/100];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    STRCharge *charge = [self.charges objectAtIndex:indexPath.row];
    return !charge.refunded;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    STRCharge *charge = [self.charges objectAtIndex:indexPath.row];
    STRStripeHTTPClient *client = [STRStripeHTTPClient sharedClient];
    [client refundCharge:charge success:^(STRCharge *charge) {
        
        NSMutableArray *mutableChargesArray = [NSMutableArray arrayWithArray:self.charges];
        [mutableChargesArray replaceObjectAtIndex:indexPath.row withObject:charge];
        self.charges = [NSArray arrayWithArray:mutableChargesArray];
        
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } failure:^(NSError *error) {
        
        NSLog(@"%@", error);
    }];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"Refund";
}

@end
