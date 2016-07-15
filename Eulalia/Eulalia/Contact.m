//
//  Contact.m
//  Eulalia
//
//  Created by Cesar Gonzales on 7/11/16.
//  Copyright © 2016 Eulalia. All rights reserved.
//

#import "Contact.h"

@implementation Contact

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        _fullName = data[@"nombreCompleto"] ? data[@"nombreCompleto"] : @"";
        _address = data[@"direccion"] ? data[@"direccion"] : @"";
        _phone = [data[@"telefono"] isKindOfClass:[NSString class]] ? data[@"telefono"] : @"";
        _institution = [data[@"institucion"] isKindOfClass:[NSString class]]? data[@"institucion"] : @"";
    }
    return self;
}

@end
