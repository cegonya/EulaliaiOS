//
//  PtoAcopioViewController.h
//  Eulalia
//
//  Created by Cesar Gonzales on 7/9/16.
//  Copyright © 2016 Eulalia. All rights reserved.
//

#import <UIKit/UIKit.h>

@import GoogleMaps;

@interface PtoAcopioViewController : UIViewController <GMSMapViewDelegate>

@property (copy, nonatomic) NSArray *ptosAcopio;
@property (copy, nonatomic) NSNumber *latitude;
@property (copy, nonatomic) NSNumber *longitude;
@property (copy, nonatomic) NSString *titleEmergencia;

@end
