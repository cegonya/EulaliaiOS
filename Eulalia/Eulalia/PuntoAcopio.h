//
//  PuntoAcopio.h
//  Eulalia
//
//  Created by Cesar Gonzales on 7/11/16.
//  Copyright © 2016 Eulalia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Need.h"
#import "Contact.h"

@interface PuntoAcopio : NSObject

@property (nonatomic, readonly) NSNumber *uid;
@property (nonatomic, readonly) NSNumber *latitude;
@property (nonatomic, readonly) NSNumber *longitude;
@property (nonatomic, readonly) NSString *departamento;
@property (nonatomic, readonly) NSString *provincia;
@property (nonatomic, readonly) NSString *distrito;
@property (nonatomic, readonly) NSString *address;
@property (nonatomic, readonly) NSString *reference;
@property (nonatomic, readonly) NSArray *needs;
@property (nonatomic, readonly) Contact *contact;

- (instancetype)initWithData:(NSDictionary *)data;

@end
