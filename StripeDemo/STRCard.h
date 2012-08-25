//
//  STRCard.h
//  StripeDemo
//
//  Created by Red Davis on 25/08/2012.
//  Copyright (c) 2012 Red Davis. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface STRCard : NSObject

@property (strong, nonatomic) NSNumber *expiryMonth;
@property (strong, nonatomic) NSNumber *expiryYear;
@property (copy, nonatomic) NSString *fingerprint;
@property (copy, nonatomic) NSString *lastFour;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *addressCity;
@property (copy, nonatomic) NSString *addressCountry;
@property (copy, nonatomic) NSString *addressLineOne;
@property (copy, nonatomic) NSString *addressLineTwo;
@property (copy, nonatomic) NSString *addressState;
@property (copy, nonatomic) NSString *addressZip;
@property (copy, nonatomic) NSString *addressZipCheck;
@property (copy, nonatomic) NSString *countryISO;
@property (copy, nonatomic) NSString *CVCCheck;
@property (copy, nonatomic) NSString *name;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
