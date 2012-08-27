//
//  STRStripeHTTPClient.m
//  StripeDemo
//
//  Created by Red Davis on 25/08/2012.
//  Copyright (c) 2012 Red Davis. All rights reserved.
//

#import "STRStripeHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "STRCustomer.h"
#import "STRCharge.h"


@interface STRStripeHTTPClient ()

@end


static NSString *kSTRStripeAPIKey = nil;
static NSString *const kSTRStripeBaseURL = @"https://api.stripe.com/v1/";
static NSString *const KSTRGetCustomersPath = @"customers";
static NSString *const KSTRChargesRootPath = @"charges";


@implementation STRStripeHTTPClient

#pragma mark - Class Methods

+ (STRStripeHTTPClient *)sharedClient {
    
    static STRStripeHTTPClient *stripeHTTPClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        stripeHTTPClient = [[STRStripeHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kSTRStripeBaseURL]];
    });
    
    return stripeHTTPClient;
}

+ (void)setAPIKey:(NSString *)APIkey {
    
    kSTRStripeAPIKey = APIkey;
}

#pragma mark - Initialization

- (id)initWithBaseURL:(NSURL *)url {
    
    self = [super initWithBaseURL:url];
    if (self) {
        
        [self setAuthorizationHeaderWithUsername:[kSTRStripeAPIKey stringByAppendingString:@":"] password:nil];
    }
    
    return self;
}

#pragma mark - Customers

- (void)fetchAllCustomers:(void(^)(NSArray *customers))success failure:(void(^)(NSError *error))failure {
        
    [self getPath:KSTRGetCustomersPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError *JSONReadingError = nil;
        id JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&JSONReadingError];
        
        NSMutableArray *customers = [NSMutableArray array];
        for (id customerData in [JSON objectForKey:@"data"]) {
            
            STRCustomer *customer = [[STRCustomer alloc] initWithDictionary:customerData];
            [customers addObject:customer];
        }
        
        success([NSArray arrayWithArray:customers]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
    }];
}

#pragma mark - Charges

- (void)fetchChargesWithParams:(NSDictionary *)params success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    
    [self getPath:KSTRChargesRootPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError *JSONReadingError = nil;
        id JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&JSONReadingError];
        
        NSMutableArray *charges = [NSMutableArray array];
        for (id chargeData in [JSON objectForKey:@"data"]) {
            
            STRCharge *charge = [[STRCharge alloc] initWithDictionary:chargeData];
            [charges addObject:charge];
        }
        
        success([NSArray arrayWithArray:charges]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
    }];
}

- (void)fetchAllCharges:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    
    [self fetchChargesWithParams:nil success:^(NSArray *charges) {
        
        success(charges);
    } failure:^(NSError *error) {
       
        failure(error);
    }];
}

- (void)fetchAllChargesForCustomerWithID:(NSString *)customerID success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:customerID, @"customer", nil];
    [self fetchChargesWithParams:params success:^(NSArray *charges) {
        
        success(charges);
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

- (void)createCharge:(NSNumber *)amount forCustomerWithID:(NSString *)customerID details:(NSString *)details success:(void (^)(STRCharge *))success failure:(void (^)(NSError *))failure {
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:amount, @"amount", customerID, @"customer", details, @"description", @"usd", @"currency", nil];
    [self createCharge:amount params:params success:^(STRCharge *charge) {
       
        success(charge);
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

- (void)createCharge:(NSNumber *)amount params:(NSDictionary *)params success:(void (^)(STRCharge *))success failure:(void (^)(NSError *))failure {
    
    [self postPath:KSTRChargesRootPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError *JSONReadingError = nil;
        id JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&JSONReadingError];
        STRCharge *charge = [[STRCharge alloc] initWithDictionary:JSON];
        
        success(charge);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
    }];
}

- (void)refundCharge:(STRCharge *)charge success:(void (^)(STRCharge *))success failure:(void (^)(NSError *))failure {
    
    NSString *refundPath = [NSString stringWithFormat:@"%@/%@/refund", KSTRChargesRootPath, charge.identifier];
    [self postPath:refundPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError *JSONReadingError = nil;
        id JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&JSONReadingError];
        STRCharge *charge = [[STRCharge alloc] initWithDictionary:JSON];
        
        success(charge);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
    }];
}

@end
