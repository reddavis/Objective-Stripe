//
//  STRCustomer.h
//  StripeDemo
//
//  Created by Red Davis on 25/08/2012.
//  Copyright (c) 2012 Red Davis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STRCard;


@interface STRCustomer : NSObject

@property (copy, nonatomic) NSString *identifier;
@property (copy, nonatomic) NSString *email;
@property (strong, nonatomic) NSDate *created;
@property (strong, nonatomic) NSNumber *accountBalance;
@property (strong, nonatomic) STRCard *activeCard;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
