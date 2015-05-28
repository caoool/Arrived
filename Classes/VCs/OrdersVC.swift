//
//  OrdersVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/4/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

struct Order {
    
    var requestId: Int?
    var phoneNumber: Int?
    var nickname: String?
    var portrait: String?
    var price: Double?
    var title: String?
    var body: String?
    var effectiveStartDate: String?
    var effectiveEndDate: String?
    var tags: String?
    var latitude: Double?
    var longitude: Double?
    var address: String?
    var status: String?
}

class OrdersVC: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    private var ordersMapViewVC: OrdersMapViewVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - Tags
    
    @IBAction func showTags(sender: UIBarButtonItem) {
        
        let item1 = Tag(issSelected: true, isLocked: true, textContent: "Hello1")
        let item2 = Tag(issSelected: true, isLocked: true, textContent: "Hello2")
        let item3 = Tag(issSelected: false, isLocked: true, textContent: "Hello3")
        let item4 = Tag(issSelected: false, isLocked: true, textContent: "Hello4")
        let item5 = Tag(issSelected: true, isLocked: true, textContent: "Hello5")
        let tags = [item1, item2, item3, item4, item5]
        
        
        
        RRTagController.displayTagController(parentController: self, tags: tags, blockFinish: { (selectedTags, unSelectedTags) -> () in
            // ok
            for tag in selectedTags {
                // TODO: save selectedTags
                self.ordersMapViewVC?.reloadScene()
                
            }
            }) { () -> () in
                // cancelled
        }
    }
    
    // MARK: - Navigations
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "OrdersMapView" {
            ordersMapViewVC = segue.destinationViewController as? OrdersMapViewVC
            
        }
    }
    
    
//    let locationManager = CLLocationManager()
//    
//    var jobs = [[String:AnyObject]]()
//    var currentJob = [String:AnyObject]()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.locationManager.delegate = self
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.locationManager.requestAlwaysAuthorization()
//        self.locationManager.startUpdatingLocation()
//        
//        //Setup our Map View
//        theMap.delegate = self
////        theMap.mapType = MKMapType.Satellite
//        theMap.showsUserLocation = true
//        
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(true)
//        
//    }
//    
//    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
//            
//            if (error != nil) {
//                println("Error:" + error.localizedDescription)
//            }
//            
//            if placemarks.count > 0 {
//                let pm = placemarks[0] as! CLPlacemark
//                self.displayLocationInfo(pm)
//                
//                let span = MKCoordinateSpanMake(0.05, 0.05)
//                let region = MKCoordinateRegion(center: manager.location.coordinate, span: span)
//                self.theMap.setRegion(region, animated: true)
//                
//                self.loadJobs()
//            } else {
//                println("Error with data")
//            }
//        
//        })
//    }
//    
//    func displayLocationInfo(placemark: CLPlacemark) {
//        
//        self.locationManager.stopUpdatingLocation()
//        
//        println(placemark.locality)
//        println(placemark.postalCode)
//        println(placemark.administrativeArea)
//        println(placemark.country)
//    }
//    
//    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
//        println("Error: " + error.localizedDescription)
//    }
//    
//    func loadJobs() {
//        
//        var dict = [String:String]()
//        dict["uid"] = NSUserDefaults.standardUserDefaults().stringForKey("uid")
//        dict["verificationCode"] = NSUserDefaults.standardUserDefaults().stringForKey("verificationCode")
//        dict["latitude"] = "\(locationManager.location.coordinate.latitude)"
//        dict["longitude"] = "\(locationManager.location.coordinate.longitude)"
//        println("\(locationManager.location.coordinate.latitude)")
//        println("\(locationManager.location.coordinate.longitude)")
//        dict["tags"] = "None"
//        dict["num"] = "10"
//        
//        let service = TestRequestService()
//        service.jobs(dict) {
//            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
//            
//            println(result!)
//            
//            if error != nil {
//                displayAlert("Get Job List - Connection Error", error!)
//            } else if checkErrorCodeInDictionary(result!) {
//                if let jobs = result!["data"] as? [[String:AnyObject]] {
//                   self.jobs = jobs
//                }
//                self.mapJobs()
//            }
//            
//        }
//    }
//    
//    func mapJobs() {
//        for job in jobs {
//            let location = CLLocationCoordinate2D(
//                latitude: (job["latitude"] as! NSString).doubleValue,
//                longitude: (job["longitude"] as! NSString).doubleValue
//            )
//            
//            let annotation = myAnnotation()
//            annotation.coordinate = location
//            annotation.title = job["nickname"] as! String
//            annotation.subtitle = job["body"] as! String
//            annotation.imageURL = job["portrait"] as? String
//            annotation.detail = job
//            theMap.addAnnotation(annotation)
//        }
//    }
//    
//    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
//        let button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
//        button.frame.size.width = 44
//        button.frame.size.height = 44
//        button.backgroundColor = UIColor.blueColor()
//        let portrait = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
//        ImageLoader.sharedLoader.imageForUrl((view.annotation as! myAnnotation).imageURL!, completionHandler:{(image: UIImage?, url: String) in
//            portrait.image = image!
//        })
//        
//        view.rightCalloutAccessoryView = button
//        view.leftCalloutAccessoryView = portrait
//        view.canShowCallout = true
//    }
//    
//    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
//        if control == view.rightCalloutAccessoryView {
//            currentJob = (view.annotation as! myAnnotation).detail!
//            performSegueWithIdentifier("OrdersToOrderDetail", sender: self)
//        }
//    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        
//        if segue.identifier == "OrdersToOrderDetail" {
//            var svc = segue.destinationViewController as! OrderDetailVC;
//            svc.toPass = currentJob
//        } else if segue.identifier == "OrdersToOrdersList" {
//            var svc = segue.destinationViewController as! OrdersListTVC;
//            svc.toPass = jobs
//        }
//        
//    }
    
    
    
    
    
    
    
}

