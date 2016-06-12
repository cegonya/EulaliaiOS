//
//  ViewController.swift
//  Eulalia
//
//  Created by Cesar Gonzales on 6/12/16.
//  Copyright © 2016 Eulalia. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, GMSMapViewDelegate {
    
    var markersEmergencias = [GMSMarker]()
    var markersPtosAcopio = [GMSMarker]()
    var mapView :GMSMapView!

    enum markerCategory: Int {
        case Emergencia = 1, PtoAcopio
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        let camera = GMSCameraPosition.cameraWithLatitude(-9.6047162, longitude: -75.8051043, zoom: 5.25)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        self.view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-12.145995, -77.0222053)
        marker.title = "Lima"
        marker.map = mapView
        marker.userData = ["Cat": markerCategory.Emergencia.rawValue, "Id": 1]
        markersEmergencias.append(marker);
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2DMake(-16.401609, -71.5370677)
        marker2.title = "Arequipa"
        marker2.map = mapView
        marker2.userData = ["Cat": markerCategory.Emergencia.rawValue, "Id": 2]
        markersEmergencias.append(marker2);
        
        let marker3 = GMSMarker()
        marker3.position = CLLocationCoordinate2DMake(-12.079156, -77.0379217)
        marker3.title = "Pto Acopio 1"
        marker3.userData = ["Cat": markerCategory.PtoAcopio.rawValue, "Id": 1]
        markersPtosAcopio.append(marker3);
        
        let marker4 = GMSMarker()
        marker4.position = CLLocationCoordinate2DMake(-12.087724, -77.0520267)
        marker4.title = "Pto Acopio 2"
        marker4.userData = ["Cat": markerCategory.PtoAcopio.rawValue, "Id": 2]
        markersPtosAcopio.append(marker4);
    }

    // MARK: Methods
    
    func loadEmergencias() {
        
        //markersEmergencias
    }
    
    // MARK: GMSMapViewDelegate
    
    func mapView(mapView: GMSMapView, didTapInfoWindowOfMarker marker: GMSMarker) {
        print("\(marker.title)")
        
        var userData: [String: Int] = marker.userData as! [String : Int]
        if userData["Cat"] == markerCategory.Emergencia.rawValue {
            //show ptos de acopio
            for marker in markersPtosAcopio {
                marker.map = mapView;
            }
            for marker in markersEmergencias {
                marker.map = nil
            }
            let camUpdate = GMSCameraUpdate .setCamera(GMSCameraPosition.cameraWithLatitude(-12.0486269, longitude: -77.0261317, zoom: 10.5))
            mapView.moveCamera(camUpdate)
        } else {
            self.performSegueWithIdentifier("SeguePtoAcopio", sender: nil)
        }
    }

}

