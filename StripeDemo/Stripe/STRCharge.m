//
//  STRCharge.m
//  StripeDemo
//
//  Created by Red Davis on 25/08/2012.
//  Copyright (c) 2012 Red Davis. All rights reserved.
//

#import "STRCharge.h"
#import "STRCard.h"


@implementation STRCharge

#pragma mark - Initialization

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [self init];
    if (self) {
        
        self.identifier = [dictionary objectForKey:@"id"];
        self.livemode = [[dictionary objectForKey:@"livemode"] boolValue];
        self.amount = [dictionary objectForKey:@"amount"];
        self.paid = [[dictionary objectForKey:@"paid"] boolValue];
        self.created = [dictionary objectForKey:@"created"];
        self.refunded = [[dictionary objectForKey:@"refunded"] boolValue];
        self.details = [dictionary objectForKey:@"description"];
        self.currency = [dictionary objectForKey:@"currency"];
        self.card = [[STRCard alloc] initWithDictionary:[dictionary objectForKey:@"card"]];
        self.disputed = [[dictionary objectForKey:@"disputed"] boolValue];
    }
    
    return self;
}

#pragma mark -

- (NSString *)description {
    
    NSMutableString *description = [NSMutableString string];
    [description appendString:[super description]];
    [description appendString:[NSString stringWithFormat:@"\n <identifier: %@>", self.identifier]];
    [description appendString:[NSString stringWithFormat:@"\n <amount : %@>", self.amount]];
    [description appendString:[NSString stringWithFormat:@"\n <livemode : %@>", [NSNumber numberWithBool:self.livemode]]];
    [description appendString:[NSString stringWithFormat:@"\n <paid : %@>", [NSNumber numberWithBool:self.paid]]];
    [description appendString:[NSString stringWithFormat:@"\n <created : %@>", self.created]];
    [description appendString:[NSString stringWithFormat:@"\n <refunded : %@>", [NSNumber numberWithBool:self.refunded]]];
    [description appendString:[NSString stringWithFormat:@"\n <details : %@>", self.details]];
    [description appendString:[NSString stringWithFormat:@"\n <disputed : %@>", [NSNumber numberWithBool:self.disputed]]];
    [description appendString:[NSString stringWithFormat:@"\n <card : %@>", self.card.description]];
    
    return description;
}

@end
