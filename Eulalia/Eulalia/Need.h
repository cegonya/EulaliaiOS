//
//  Need.h
//  Eulalia
//
//  Created by Cesar Gonzales on 7/11/16.
//  Copyright © 2016 Eulalia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Need : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSNumber *goal;
@property (nonatomic, readonly) NSNumber *current;
@property (nonatomic, readonly) NSNumber *priority;

- (instancetype)initWithData:(NSDictionary *)data;

@end
