//
//  STRCard.m
//  StripeDemo
//
//  Created by Red Davis on 25/08/2012.
//  Copyright (c) 2012 Red Davis. All rights reserved.
//

#import "STRCard.h"


@implementation STRCard

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [self init];
    if (self) {
        
        self.expiryMonth = [dictionary objectForKey:@"exp_month"];
        self.expiryYear = [dictionary objectForKey:@"exp_year"];
        self.fingerprint = [dictionary objectForKey:@"fingerprint"];
        self.lastFour = [dictionary objectForKey:@"last4"];
        self.type = [dictionary objectForKey:@"type"];
        self.addressCity = [dictionary objectForKey:@"address_city"];
        self.addressCountry = [dictionary objectForKey:@"address_country"];
        self.addressLineOne = [dictionary objectForKey:@"address_line1"];
        self.addressLineTwo = [dictionary objectForKey:@"address_line2"];
        self.addressState = [dictionary objectForKey:@"address_state"];
        self.addressZip = [dictionary objectForKey:@"address_zip"];
        self.addressZipCheck = [dictionary objectForKey:@"address_zip_check"];
        self.countryISO = [dictionary objectForKey:@"country"];
        self.CVCCheck = [dictionary objectForKey:@"cvc_check"];
        self.name = [dictionary objectForKey:@"name"];
    }
    
    return self;
}

#pragma mark -

- (NSString *)description {
    
    NSMutableString *description = [NSMutableString string];
    [description appendString:[super description]];
    [description appendString:[NSString stringWithFormat:@"\n <expiryMonth : %@>", self.expiryMonth]];
    [description appendString:[NSString stringWithFormat:@"\n <expiryYear : %@>", self.expiryYear]];
    [description appendString:[NSString stringWithFormat:@"\n <fingerPrint : %@>", self.fingerprint]];
    [description appendString:[NSString stringWithFormat:@"\n <lastFour : %@>", self.lastFour]];
    [description appendString:[NSString stringWithFormat:@"\n <addressLineOne : %@>", self.addressLineOne]];
    [description appendString:[NSString stringWithFormat:@"\n <addressLineTwo : %@>", self.addressLineTwo]];
    [description appendString:[NSString stringWithFormat:@"\n <addressState : %@>", self.addressState]];
    [description appendString:[NSString stringWithFormat:@"\n <addressCity : %@>", self.addressCity]];
    [description appendString:[NSString stringWithFormat:@"\n <addressCountry : %@>", self.addressCountry]];
    [description appendString:[NSString stringWithFormat:@"\n <addressZip : %@>", self.addressZip]];
    [description appendString:[NSString stringWithFormat:@"\n <addressZipCheck: %@>", self.addressZipCheck]];
    [description appendString:[NSString stringWithFormat:@"\n <countryISO: %@>", self.countryISO]];
    [description appendString:[NSString stringWithFormat:@"\n <CVCCheck: %@>", self.CVCCheck]];
    [description appendString:[NSString stringWithFormat:@"\n <name: %@>", self.name]];
    
    return description;
}

@end
