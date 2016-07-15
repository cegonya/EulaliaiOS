//
//  PtoAcopioDetailViewController.h
//  Eulalia
//
//  Created by Cesar Gonzales on 7/15/16.
//  Copyright © 2016 Eulalia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PtoAcopioDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (copy, nonatomic) NSString *ptoAcopioUID;

@end
