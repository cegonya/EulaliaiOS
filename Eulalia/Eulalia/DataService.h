//
//  DataService.h
//  Eulalia
//
//  Created by Cesar Gonzales on 7/9/16.
//  Copyright © 2016 Eulalia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Emergencia.h"
#import "PuntoAcopio.h"

@interface DataService : NSObject

+ (instancetype)sharedInstance;
- (void)getEmergencias:(void (^)(NSArray *emergencias))success failure:(void (^)(NSError *error))failure;
- (void)getPtoAcopioWithId:(NSString *)uid success:(void (^)(PuntoAcopio *puntoAcopio))success failure:(void (^)(NSError *error))failure;

@end
