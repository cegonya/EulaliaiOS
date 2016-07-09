//
//  DataService.m
//  Eulalia
//
//  Created by Cesar Gonzales on 7/9/16.
//  Copyright © 2016 Eulalia. All rights reserved.
//

#import "DataService.h"
#import <AFNetworking/AFNetworking.h>

static NSString *const baseURL = @"http://127.0.0.1:8088/service/";

@interface DataService ()

@property(strong, nonatomic) AFHTTPSessionManager *sessionManager;
@property(strong, nonatomic) NSMutableArray *emergencias;

@end

@implementation DataService

+ (instancetype)sharedInstance
{
    static id              sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      sharedInstance = [[self alloc] init];
                  });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _emergencias = [NSMutableArray new];
    }
    
    return self;
}

- (void)getEmergencias:(void (^)(NSArray *emergencias))success failure:(void (^)(NSError *error))failure
{
    
    [self.sessionManager GET:@"emergencias"
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionDataTask *task, id response){
                         for (NSDictionary *emergenciaData in response[@"emergencias"]) {
                             Emergencia *emergencia = [[Emergencia alloc] initWithData:emergenciaData];
                             if (emergencia) {
                                 [self.emergencias addObject:emergencia];
                             }
                         }
                         success([NSArray arrayWithArray:self.emergencias]);
                     }
                     failure:^(NSURLSessionDataTask *task, NSError *error){
                         NSLog(@"error : %@",error);
                     }];
}

- (void)getPtoAcopioWithId:(NSString *)uid success:(void (^)(NSArray *emergencias))success failure:(void (^)(NSError *error))failure
{
    [self.sessionManager GET:[NSString stringWithFormat:@"puntodeacopio/%@",uid]
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionDataTask *task, id response){
                         NSLog(@"data : %@",response);
                     }
                     failure:^(NSURLSessionDataTask *task, NSError *error){
                         NSLog(@"error : %@",error);
                     }];
}

@end
