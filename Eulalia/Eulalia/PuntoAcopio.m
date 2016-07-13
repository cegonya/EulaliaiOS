//
//  PuntoAcopio.m
//  Eulalia
//
//  Created by Cesar Gonzales on 7/11/16.
//  Copyright © 2016 Eulalia. All rights reserved.
//

#import "PuntoAcopio.h"

@implementation PuntoAcopio

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    
    if (self) {
        if (!data[@"id"]) {
            return nil;
        } else {
            _uid = data[@"id"];
        }
        
        _latitude = data[@"latitud"] ? data [@"latitud"] : @(0);
        _longitude = data[@"longitud"] ? data [@"longitud"] : @(0);
        _departamento = data[@"departamento"] ? data[@"departamento"] : @"";
        _provincia = data[@"provincia"] ? data[@"provincia"] : @"";
        _distrito = data[@"distrito"] ? data[@"distrito"] : @"";
        _address = data[@"direccion"] ? data[@"direccion"] : @"";
        _reference = data[@"referencia"] ? data[@"referencia"] : @"";
        
        NSArray *needs = data[@"necesidades"];
        NSMutableArray *tempNeeds = [NSMutableArray new];
        if ([needs isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dictionaryNeed in needs) {
                if ([dictionaryNeed isKindOfClass:[NSDictionary class]]) {
                    Need *need = [[Need alloc] initWithData:dictionaryNeed];
                    if (need) {
                        [tempNeeds addObject:need];
                    }
                }
            }
            _needs = [NSArray arrayWithArray:tempNeeds];
        }
        NSDictionary *contactData = data[@"contacto"];
        if ([contactData isKindOfClass:[NSDictionary class]]) {
            _contact = [[Contact alloc] initWithData:contactData];
        }
    }
    
    return self;
}

@end
