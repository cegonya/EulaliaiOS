//
//  NeedTableViewCell.h
//  Eulalia
//
//  Created by Cesar Gonzales on 7/15/16.
//  Copyright © 2016 Eulalia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NeedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIView *viewChild;
@property (weak, nonatomic) IBOutlet UIView *viewParent;
@property (weak, nonatomic) IBOutlet UILabel *labelPercentage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutConstraintWidthViewChild;
@end
