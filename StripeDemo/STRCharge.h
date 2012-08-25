//
//  STRCharge.h
//  StripeDemo
//
//  Created by Red Davis on 25/08/2012.
//  Copyright (c) 2012 Red Davis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  STRCard;


@interface STRCharge : NSObject

@property (copy, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSNumber *amount;
@property (assign, nonatomic) BOOL livemode;
@property (assign, nonatomic) BOOL paid;
@property (strong, nonatomic) NSDate *created;
@property (assign, nonatomic) BOOL refunded;
@property (copy, nonatomic) NSString *details;
@property (copy, nonatomic) NSString *currency;
@property (strong, nonatomic) STRCard *card;
@property (assign, nonatomic) BOOL disputed;


- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
