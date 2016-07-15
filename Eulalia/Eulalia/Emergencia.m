//
//  Emergencia.m
//  Eulalia
//
//  Created by Cesar Gonzales on 7/9/16.
//  Copyright © 2016 Eulalia. All rights reserved.
//

#import "Emergencia.h"
#import "PuntoAcopio.h"

@interface Emergencia()

@property (strong, nonatomic) NSNumber *uid;
@property (strong, nonatomic) NSString *tipo;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSString *departamento;
@property (strong, nonatomic) NSString *provincia;
@property (strong, nonatomic) NSString *distrito;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *descriptionEmergencia;
@property (strong, nonatomic) NSArray *ptosAcopio;

@end

@implementation Emergencia

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    
    if (self) {
        if (!data[@"id"]) {
            return nil;
        } else {
            _uid = data[@"id"];
        }
        
        _tipo = data[@"tipo"] ? data [@"tipo"] : @"";
        _latitude = data[@"latitud"] ? data [@"latitud"] : @(0);
        _longitude = data[@"longitud"] ? data [@"longitud"] : @(0);
        _departamento = data[@"departamento"] ? data[@"departamento"] : @"";
        _provincia = data[@"provincia"] ? data[@"provincia"] : @"";
        _distrito = data[@"distrito"] ? data[@"distrito"] : @"";
        _title = data[@"titulo"] ? data[@"titulo"] : @"";
        _descriptionEmergencia = data[@"descripcion"] ? data[@"descripcion"] : @"";
        
        NSArray *ptosAcopioData = data[@"puntos de acopio"];
        NSMutableArray *ptosAcopio = [NSMutableArray new];
        if (ptosAcopioData) {
            for (NSDictionary *dictionaryPtoAcopio in ptosAcopioData) {
                PuntoAcopio *puntoAcopio = [[PuntoAcopio alloc] initWithData:dictionaryPtoAcopio];
                if (puntoAcopio) {
                    [ptosAcopio addObject:puntoAcopio];
                }
                
            }
            _ptosAcopio = [NSArray arrayWithArray:ptosAcopio];
        } else {
            _ptosAcopio = [NSArray new];
        }
    }
    
    return self;
}


@end
