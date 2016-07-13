//
//  ViewController.m
//  Eulalia
//
//  Created by Cesar Gonzales on 7/8/16.
//  Copyright © 2016 Eulalia. All rights reserved.
//

#import "ViewController.h"
#import "DataService.h"

@interface ViewController ()

@property (strong, nonatomic) GMSMapView *mapView;
@property (strong, nonatomic) NSArray *emergencias;
@property (weak, nonatomic) IBOutlet UIView *viewGMSMap;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDepartamento;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintEmergenciaDetailBottomLayout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-9.6047162
                                                            longitude:-75.8051043
                                                                 zoom:5.25];
    self.mapView = [GMSMapView mapWithFrame:self.viewGMSMap.bounds camera:camera];
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.myLocationButton = YES;
    self.mapView.delegate = self;
    [self.viewGMSMap addSubview:self.mapView];
    
    self.constraintEmergenciaDetailBottomLayout.constant = -140;
    [self loadEmergenciasData];
    
    DataService *dataService = [DataService sharedInstance];
    [dataService getPtoAcopioWithId:@"1"
                            success:^(PuntoAcopio *puntoAcopio){
                            
                            }
                            failure:^(NSError *error){
                            
                            }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    for (Emergencia *emergencia in self.emergencias) {
        // Creates a marker in the center of the map.
        GMSMarker *marker = [[GMSMarker alloc] init];
        //marker.position = CLLocationCoordinate2DMake(-12.145995, -77.0222053);
        marker.position = CLLocationCoordinate2DMake([emergencia.latitude doubleValue], [emergencia.longitude doubleValue]);
        marker.title = emergencia.departamento;
        marker.snippet = emergencia.title;
        marker.userData = emergencia;
        marker.map = self.mapView;
    }
    
}

#pragma mark GMS MapView Delegate

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    [UIView animateWithDuration:3.0f
                     animations:^{
                         self.constraintEmergenciaDetailBottomLayout.constant = 0;
                         [self.viewGMSMap layoutIfNeeded];
                     }];
    
    return YES;
}

@end
