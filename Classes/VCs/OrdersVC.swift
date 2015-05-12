//
//  OrdersVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/4/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class myAnnotation: MKPointAnnotation {
    
    var imageURL: String?
    var detail: [String:AnyObject]?
}

class OrdersVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var theMap: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var jobs = [[String:AnyObject]]()
    var currentJob = [String:AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        
        //Setup our Map View
        theMap.delegate = self
//        theMap.mapType = MKMapType.Satellite
        theMap.showsUserLocation = true
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                println("Error:" + error.localizedDescription)
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pm)
                
                let span = MKCoordinateSpanMake(0.05, 0.05)
                let region = MKCoordinateRegion(center: manager.location.coordinate, span: span)
                self.theMap.setRegion(region, animated: true)
                
                self.loadJobs()
            } else {
                println("Error with data")
            }
        
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        
        self.locationManager.stopUpdatingLocation()
        
        println(placemark.locality)
        println(placemark.postalCode)
        println(placemark.administrativeArea)
        println(placemark.country)
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: " + error.localizedDescription)
    }
    
    func loadJobs() {
        
        var dict = [String:String]()
        dict["uid"] = NSUserDefaults.standardUserDefaults().stringForKey("uid")
        dict["verificationCode"] = NSUserDefaults.standardUserDefaults().stringForKey("verificationCode")
        dict["latitude"] = "\(locationManager.location.coordinate.latitude)"
        dict["longitude"] = "\(locationManager.location.coordinate.longitude)"
        println("\(locationManager.location.coordinate.latitude)")
        println("\(locationManager.location.coordinate.longitude)")
        dict["tags"] = "None"
        dict["num"] = "10"
        
        let service = TestRequestService()
        service.jobs(dict) {
            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
            
            println(result!)
            
            if error != nil {
                displayAlert("Get Job List - Connection Error", error!)
            } else if checkErrorCodeInDictionary(result!) {
                if let jobs = result!["data"] as? [[String:AnyObject]] {
                   self.jobs = jobs
                }
                self.mapJobs()
            }
            
        }
    }
    
    func mapJobs() {
        for job in jobs {
            let location = CLLocationCoordinate2D(
                latitude: (job["latitude"] as! NSString).doubleValue,
                longitude: (job["longitude"] as! NSString).doubleValue
            )
            
            let annotation = myAnnotation()
            annotation.coordinate = location
            annotation.title = job["nickname"] as! String
            annotation.subtitle = job["body"] as! String
            annotation.imageURL = job["portrait"] as? String
            annotation.detail = job
            theMap.addAnnotation(annotation)
        }
    }
    
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        let button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        button.frame.size.width = 44
        button.frame.size.height = 44
        button.backgroundColor = UIColor.blueColor()
        let portrait = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        ImageLoader.sharedLoader.imageForUrl((view.annotation as! myAnnotation).imageURL!, completionHandler:{(image: UIImage?, url: String) in
            portrait.image = image!
        })
        
        view.rightCalloutAccessoryView = button
        view.leftCalloutAccessoryView = portrait
        view.canShowCallout = true
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        if control == view.rightCalloutAccessoryView {
            currentJob = (view.annotation as! myAnnotation).detail!
            performSegueWithIdentifier("OrdersToOrderDetail", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "OrdersToOrderDetail" {
            var svc = segue.destinationViewController as! OrderDetailVC;
            svc.toPass = currentJob
        } else if segue.identifier == "OrdersToOrdersList" {
            var svc = segue.destinationViewController as! OrdersListTVC;
            svc.toPass = jobs
        }
        
    }
    
    
    
    
    
    
    
}
