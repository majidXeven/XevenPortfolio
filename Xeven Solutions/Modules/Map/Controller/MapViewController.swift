//
//  MapViewController.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 03/01/2020.
//  Copyright © 2020 IMedHealth. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: BaseViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }

        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true

        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
        resetMap()
    }
    
    func resetMap(){
        // Clear all annotations first
        let annotationsToRemove = mapView.annotations
        mapView.removeAnnotations(annotationsToRemove)
        // Set starting point of map: downtown Raleigh
        let latitude:CLLocationDegrees = 31.454413199999998
        let longitude:CLLocationDegrees = 74.2766072
        // Zoom level
        let latDelta:CLLocationDegrees = 0.09
        let longDelta:CLLocationDegrees = 0.09
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Xeven Solutions"
        annotation.subtitle = "15 Civic Center (Basement), D2 Block, Johar Town - Lahore"
        mapView.addAnnotation(annotation)
    }
    
    
    @IBAction func onPressClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let locValue:CLLocationCoordinate2D = manager.location!.coordinate

//        mapView.mapType = MKMapType.standard
//
//        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        let region = MKCoordinateRegion(center: locValue, span: span)
//        mapView.setRegion(region, animated: true)
//
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = locValue
//        annotation.title = "Xeven Solutions"
//        annotation.subtitle = "15 Civic Center (Basement), D2 Block, Johar Town - Lahore"
//        mapView.addAnnotation(annotation)

        //centerMap(locValue)
    }
    
}
