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
        _fullName = data[@"nombre completo"] ? data[@"nombre completo"] : @"";
        _address = data[@"direccion"] ? data[@"direccion"] : @"";
        _phone = data[@"telefono"] ? data[@"telefono"] : @"";
        _institution = data[@"institucion"] ? data[@"institucion"] : @"";
    }
    return self;
}

@end
