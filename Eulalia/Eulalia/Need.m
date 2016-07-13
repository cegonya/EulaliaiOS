//
//  Need.m
//  Eulalia
//
//  Created by Cesar Gonzales on 7/11/16.
//  Copyright © 2016 Eulalia. All rights reserved.
//

#import "Need.h"

@implementation Need

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        _name = data[@"nombre"] ? data[@"nombre"] : @"";
        _goal = data[@"objetivo"] ? data [@"objetivo"] : @(0);
        _current = data[@"actual"] ? data [@"actual"] : @(0);
        _priority = data[@"prioridad"] ? data [@"prioridad"] : @(0);
    }
    return self;
}

@end
