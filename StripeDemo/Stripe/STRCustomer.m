//
//  STRCustomer.m
//  StripeDemo
//
//  Created by Red Davis on 25/08/2012.
//  Copyright (c) 2012 Red Davis. All rights reserved.
//

#import "STRCustomer.h"
#import "STRCard.h"


@implementation STRCustomer

#pragma mark - Initialization

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [self init];
    if (self) {
        
        self.identifier = [dictionary objectForKey:@"id"];
        self.email = [dictionary objectForKey:@"email"];
        self.created = [dictionary objectForKey:@"created"];
        self.accountBalance = [dictionary objectForKey:@"accountBalance"];
        
        NSDictionary *cardDictionary = [dictionary objectForKey:@"active_card"];
        if (cardDictionary) {
            self.activeCard = [[STRCard alloc] initWithDictionary:cardDictionary];
        }
    }
    
    return self;
}

#pragma mark -

- (NSString *)description {
    
    NSMutableString *description = [NSMutableString string];
    [description appendString:[super description]];
    [description appendString:[NSString stringWithFormat:@"\n <identifier : %@>", self.identifier]];
    [description appendString:[NSString stringWithFormat:@"\n <email : %@>", self.email]];
    [description appendString:[NSString stringWithFormat:@"\n <created : %@>", self.created]];
    [description appendString:[NSString stringWithFormat:@"\n <accountBalance : %@>", self.accountBalance]];
    
    return description;
}

@end
