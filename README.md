# Objective Stripe

## Overview

This is an Objective-C wrapper for the Stripe API.

It's nowhere near complete yet, but the foundations are in place. 

If you open the project there is a demo app. To try it out, you must add a "StripePublishableKey" file, with your key inside, to the project.

## How To Use

```objective-c

// Start by setting your API key
[STRStripeHTTPClient setAPIKey:@"your_stripe_key"];

// Then you have access to these methods

// Customers
- (void)fetchAllCustomers:(void(^)(NSArray *customers))success failure:(void(^)(NSError *error))failure;

// Charges
- (void)fetchChargesWithParams:(NSDictionary *)params success:(void (^)(NSArray *charges))success failure:(void (^)(NSError *error))failure;
- (void)fetchAllCharges:(void(^)(NSArray *charges))success failure:(void(^)(NSError *error))failure;
- (void)fetchAllChargesForCustomerWithID:(NSString *)customerID success:(void(^)(NSArray *charges))success failure:(void(^)(NSError *error))failure;
- (void)createCharge:(NSNumber *)amount forCustomerWithID:(NSString *)customerID details:(NSString *)details success:(void(^)(STRCharge *charge))success failure:(void(^)(NSError *error))failure;
- (void)createCharge:(NSNumber *)amount params:(NSDictionary *)params success:(void(^)(STRCharge *charge))success failure:(void(^)(NSError *error))failure;
- (void)refundCharge:(STRCharge *)charge success:(void(^)(STRCharge *charge))success failure:(void(^)(NSError *error))failure;

```
