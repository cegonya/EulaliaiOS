//
//  ViewController.m
//  Eulalia
//
//  Created by Cesar Gonzales on 7/8/16.
//  Copyright © 2016 Eulalia. All rights reserved.
//

#import "ViewController.h"
#import "DataService.h"
#import "PtoAcopioViewController.h"

@interface ViewController ()

@property (strong, nonatomic) GMSMapView *mapView;
@property (strong, nonatomic) NSArray *emergencias;
@property (strong, nonatomic) NSMutableArray *markers;
@property (weak, nonatomic) IBOutlet UIView *viewGMSMap;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDepartamento;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintEmergenciaDetailBottomLayout;
@property (strong, nonatomic) Emergencia *emergenciaSelected;

- (IBAction)tapOnEmergencia:(UITapGestureRecognizer *)sender;

@end

@implementation ViewController

#pragma mark lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-10.6047162
                                                            longitude:-73.8051043
                                                                 zoom:5.2];
    self.mapView = [GMSMapView mapWithFrame:self.viewGMSMap.bounds camera:camera];
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.myLocationButton = YES;
    self.mapView.delegate = self;
    [self.viewGMSMap addSubview:self.mapView];
    
    self.markers = [NSMutableArray new];
    self.constraintEmergenciaDetailBottomLayout.constant = -140;
    [self loadEmergenciasData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.title = @"Emergencias";
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.title = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueShowPuntosAcopio"]) {
        NSLog(@"%@",self.emergenciaSelected);
        PtoAcopioViewController *VCPtoAcopio = segue.destinationViewController;
        VCPtoAcopio.ptosAcopio = self.emergenciaSelected.ptosAcopio;
        VCPtoAcopio.latitude = self.emergenciaSelected.latitude;
        VCPtoAcopio.longitude = self.emergenciaSelected.longitude;
        VCPtoAcopio.titleEmergencia = self.emergenciaSelected.title;
    }
}

#pragma mark - Private Methods

- (void)loadEmergenciasData
{
    DataService *dataService = [DataService sharedInstance];
    [dataService getEmergencias:^(NSArray *emergencias){
        self.emergencias = emergencias;
        [self addMarkers];
        
    }
                        failure:^(NSError *error){
                     //show alert
                        }];
}

- (void)addMarkers
{
    [self.mapView clear];
    [self.markers removeAllObjects];
    
    for (Emergencia *emergencia in self.emergencias) {
        // Creates a marker in the center of the map.
        GMSMarker *marker = [[GMSMarker alloc] init];
        //marker.position = CLLocationCoordinate2DMake(-12.145995, -77.0222053);
        marker.position = CLLocationCoordinate2DMake([emergencia.latitude doubleValue], [emergencia.longitude doubleValue]);
        marker.title = emergencia.departamento;
        marker.snippet = emergencia.title;
        marker.userData = emergencia;
        marker.icon = [UIImage imageNamed:@"Pin1"];
        marker.map = self.mapView;
        [self.markers addObject:marker];
    }
    
}

#pragma mark GMS MapView Delegate

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    self.emergenciaSelected = marker.userData;
    self.labelTitle.text = self.emergenciaSelected.title;
    self.labelDepartamento.text = self.emergenciaSelected.departamento;
    self.labelDescription.text = self.emergenciaSelected.descriptionEmergencia;
    
    for (GMSMarker *oneMarker in self.markers) {
        oneMarker.icon = [UIImage imageNamed:@"Pin1"];
    }
    
    marker.icon = [UIImage imageNamed:@"Pin1_selected"];
    
    [UIView animateWithDuration:3.0f
                     animations:^{
                         self.constraintEmergenciaDetailBottomLayout.constant = 0;
                         [self.viewGMSMap layoutIfNeeded];
                     }];
    
    return YES;
}

#pragma mark Actions

- (IBAction)tapOnEmergencia:(UITapGestureRecognizer *)sender
{
    [self performSegueWithIdentifier:@"segueShowPuntosAcopio"
                              sender:nil];
}
@end
