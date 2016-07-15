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
@property (weak, nonatomic) IBOutlet UILabel *labelDetail1;
@property (weak, nonatomic) IBOutlet UILabel *labelDetail2;
@property (weak, nonatomic) IBOutlet UILabel *labelDetail3;
- (IBAction)refreshButtonTap:(UIBarButtonItem *)sender;

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
    self.labelDetail1.text = [@"" stringByAppendingString:self.puntoAcopio.address];
    self.labelDetail2.text = [@"Teléfono: " stringByAppendingString:self.puntoAcopio.contact.phone];
    self.labelDetail3.text = [self.puntoAcopio.contact.institution isEqualToString:@""] ? [@"Contacto: " stringByAppendingString:self.puntoAcopio.contact.fullName] : [@"Institución: " stringByAppendingString:self.puntoAcopio.contact.institution];
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
    cell.labelTitle.text = [NSString stringWithFormat:@"%@ %@",need.goal, need.name];
    float percentage = ([need.current intValue]*1.0/[need.goal intValue])*100.0;
    cell.labelPercentage.text = [NSString stringWithFormat:@"%d %%",(int)percentage];
    cell.layoutConstraintWidthViewChild.constant = cell.viewParent.frame.size.width*(percentage/100);
    
    return cell;
}

- (IBAction)refreshButtonTap:(UIBarButtonItem *)sender
{
    [self requestPtoAcopioData];
}
@end
