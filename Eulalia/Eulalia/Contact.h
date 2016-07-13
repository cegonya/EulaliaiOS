//
//  Contact.h
//  Eulalia
//
//  Created by Cesar Gonzales on 7/11/16.
//  Copyright © 2016 Eulalia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (nonatomic, readonly) NSString *fullName;
@property (nonatomic, readonly) NSString *address;
@property (nonatomic, readonly) NSString *phone;
@property (nonatomic, readonly) NSString *institution;

- (instancetype)initWithData:(NSDictionary *)data;

@end
