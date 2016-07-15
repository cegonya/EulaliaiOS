//
//  Emergencia.h
//  Eulalia
//
//  Created by Cesar Gonzales on 7/9/16.
//  Copyright © 2016 Eulalia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Emergencia : NSObject

@property (nonatomic, readonly) NSNumber *uid;
@property (nonatomic, readonly) NSString *tipo;
@property (nonatomic, readonly) NSNumber *latitude;
@property (nonatomic, readonly) NSNumber *longitude;
@property (nonatomic, readonly) NSString *departamento;
@property (nonatomic, readonly) NSString *provincia;
@property (nonatomic, readonly) NSString *distrito;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *descriptionEmergencia;
@property (nonatomic, readonly) NSArray *ptosAcopio;

- (instancetype)initWithData:(NSDictionary *)data;

@end
