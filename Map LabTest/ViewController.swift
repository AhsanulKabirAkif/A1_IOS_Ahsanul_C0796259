//
//  ViewController.swift
//  Map LabTest
//
//  Created by Ahsanul Kabir on 18/5/21.
//  Copyright © 2021 Ahsanul Kabir. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var directionBtn: UIButton!
    var locationManager = CLLocationManager()
    var count = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        directionBtn.isHidden = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let uiLpgr = UILongPressGestureRecognizer(target: self, action: #selector(addLongPressAnnotation))
        map.addGestureRecognizer(uiLpgr)
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0]
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        displayLocation(latitude: latitude, longitude: longitude, title: "Your Location", subtitle: "You are here")
    }
    func displayLocation(latitude: CLLocationDegrees,longitude: CLLocationDegrees,title: String,subtitle: String){
        let latDelta:CLLocationDegrees = 0.05
        let lngDelta:CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lngDelta)
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.subtitle = subtitle
        annotation.coordinate = location
        map.addAnnotation(annotation)
        
    }
    @objc func addLongPressAnnotation(_ gestureRecognizer: UIGestureRecognizer){
        //map.removeAnnotations(map.annotations)
        let touchpoint = gestureRecognizer.location(in: map)
        let coordinate = map.convert(touchpoint, toCoordinateFrom: map)
        let annotation = MKPointAnnotation()
        
        directionBtn.isHidden = false
        if count == 0 {
            annotation.title = "A"
            annotation.coordinate = coordinate
            map.addAnnotation(annotation)
        }
         if count == 1 {
            annotation.title = "B"
            annotation.coordinate = coordinate
            map.addAnnotation(annotation)
            
        }
        if count == 2 {
            annotation.title = "C"
            annotation.coordinate = coordinate
            map.addAnnotation(annotation)
            
        }
            
        else if count == 3 {
            map.removeAnnotations(map.annotations)
            count = 0
            
        }
        count = count+1
        
        
    }


}

