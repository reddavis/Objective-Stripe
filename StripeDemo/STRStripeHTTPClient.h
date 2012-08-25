//
//  STRStripeHTTPClient.h
//  StripeDemo
//
//  Created by Red Davis on 25/08/2012.
//  Copyright (c) 2012 Red Davis. All rights reserved.
//

#import "AFHTTPClient.h"

@class STRCharge;


@interface STRStripeHTTPClient : AFHTTPClient

+ (STRStripeHTTPClient *)sharedClient;
+ (void)setAPIKey:(NSString *)APIkey;

- (void)fetchAllCustomers:(void(^)(NSArray *customers))success failure:(void(^)(NSError *error))failure;
- (void)fetchAllChargesForCustomerWithID:(NSString *)customerID success:(void(^)(NSArray *charges))success failure:(void(^)(NSError *error))failure;
- (void)createCharge:(NSNumber *)amount forCustomerWithID:(NSString *)customerID details:(NSString *)details success:(void(^)(STRCharge *charge))success failure:(void(^)(NSError *error))failure;

@end
