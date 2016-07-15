//
//  PtoAcopioViewController.m
//  Eulalia
//
//  Created by Cesar Gonzales on 7/9/16.
//  Copyright © 2016 Eulalia. All rights reserved.
//

#import "PtoAcopioViewController.h"
#import "PtoAcopioDetailViewController.h"
#import "DataService.h"

@interface PtoAcopioViewController ()

@property (strong, nonatomic) GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *viewGMSMap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintPtoAcopioDetailBottomLayout;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelAddress;
@property (weak, nonatomic) IBOutlet UILabel *labelPhone;
@property (weak, nonatomic) IBOutlet UILabel *labelContact;
@property (strong, nonatomic) PuntoAcopio *ptoAcopioSelected;

- (IBAction)tapOnPuntoAcopio:(UITapGestureRecognizer *)sender;

@end

@implementation PtoAcopioViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[self.latitude doubleValue]
                                                            longitude:[self.longitude doubleValue]
                                                                 zoom:10.5];
    self.mapView = [GMSMapView mapWithFrame:self.viewGMSMap.bounds camera:camera];
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.myLocationButton = YES;
    self.mapView.delegate = self;
    [self.viewGMSMap addSubview:self.mapView];
    
    self.constraintPtoAcopioDetailBottomLayout.constant = -140;
    [self addMarkers];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.title = @"Puntos de Acopio";
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.title = @"";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //
    if ([segue.identifier isEqualToString:@"segueShowPuntoAcopio"]) {
        PtoAcopioDetailViewController *VCPtoAcopioDetail = [segue destinationViewController];
        VCPtoAcopioDetail.ptoAcopioUID = self.ptoAcopioSelected.uid;
    }
}

- (void)addMarkers
{
    [self.mapView clear];
    
    for (PuntoAcopio *puntoAcopio in self.ptosAcopio) {
        // Creates a marker in the center of the map.
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake([puntoAcopio.latitude doubleValue], [puntoAcopio.longitude doubleValue]);
        marker.userData = puntoAcopio;
        marker.icon = [UIImage imageNamed:@"Pin2"];
        marker.map = self.mapView;
    }
    
}

#pragma mark GMS MapView Delegates

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    self.ptoAcopioSelected = marker.userData;
    self.labelTitle.text = @"Punto de Acopio";
    self.labelAddress.text = self.ptoAcopioSelected.address;
    self.labelPhone.text = self.ptoAcopioSelected.distrito;
    self.labelContact.text =  self.ptoAcopioSelected.provincia;
    
    [UIView animateWithDuration:3.0f
                     animations:^{
                         self.constraintPtoAcopioDetailBottomLayout.constant = 0;
                         [self.viewGMSMap layoutIfNeeded];
                     }];
    
    return YES;
}

#pragma mark Actions

- (IBAction)tapOnPuntoAcopio:(UITapGestureRecognizer *)sender
{
    [self performSegueWithIdentifier:@"segueShowPuntoAcopio"
                              sender:nil];
}
@end
