//
//  PtoAcopioDetailViewController.m
//  Eulalia
//
//  Created by Cesar Gonzales on 7/15/16.
//  Copyright © 2016 Eulalia. All rights reserved.
//

#import "PtoAcopioDetailViewController.h"
#import "DataService.h"
#import "NeedTableViewCell.h"

@interface PtoAcopioDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableViewNeeds;
@property (strong, nonatomic) PuntoAcopio *puntoAcopio;

@end

@implementation PtoAcopioDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self requestPtoAcopioData];
}

- (void)requestPtoAcopioData
{
    DataService *dataService = [DataService sharedInstance];
    [dataService getPtoAcopioWithId:self.ptoAcopioUID
                            success:^(PuntoAcopio *puntoAcopio){
                                self.puntoAcopio = puntoAcopio;
                                [self updateUI];
                            }
                            failure:^(NSError *error){
                            }];
}

- (void)updateUI
{
    [self.tableViewNeeds reloadData];
}

#pragma mark UITableView Data Source
//

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.puntoAcopio ? [self.puntoAcopio.needs count] : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellNeed" forIndexPath:indexPath];
    
    Need *need = self.puntoAcopio.needs[indexPath.row];
    cell.labelTitle.text = need.name;
    float percentage = ([need.current intValue]*1.0/[need.goal intValue])*100.0;
    cell.labelPercentage.text = [NSString stringWithFormat:@"%d %%",(int)percentage];
    cell.layoutConstraintWidthViewChild.constant = cell.viewParent.frame.size.width*(percentage/100);
    
    return cell;
}

@end
