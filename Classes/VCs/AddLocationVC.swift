//
//  AddLocationVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/3/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit
import MapKit
import AddressBookUI

class AddLocationVC: UIViewController, MKMapViewDelegate, UISearchBarDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        navigationController?.navigationBar.topItem!.title = "";
    }
    
    /*
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var latitude: Double?
    var longitude: Double?
    
    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        navigationController?.navigationBar.topItem!.title = "";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func showSearchBar(sender: AnyObject) {
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        presentViewController(searchController, animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        
        searchBar.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
        if self.mapView.annotations.count != 0{
            annotation = self.mapView.annotations[0] as! MKAnnotation
            self.mapView.removeAnnotation(annotation)
        }
        
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.startWithCompletionHandler { (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil{
                var alert = UIAlertView(title: nil, message: "Place not found", delegate: self, cancelButtonTitle: "Try again")
                alert.show()
                return
            }
            
            self.latitude = localSearchResponse.boundingRegion.center.latitude
            self.longitude = localSearchResponse.boundingRegion.center.longitude
            
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = searchBar.text
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: self.latitude!, longitude: self.longitude!)
            
            
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
//            self.mapView.centerCoordinate = self.pointAnnotation.coordinate
            
            
            let center = CLLocationCoordinate2D(latitude: self.latitude!, longitude: self.longitude!)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            self.mapView.setRegion(region, animated: true)
            self.mapView.addAnnotation(self.pinAnnotationView.annotation)
            
            var locationManager = LocationManager.sharedInstance
            locationManager.reverseGeocodeLocationWithLatLon(latitude: self.latitude!, longitude: self.longitude!) { (reverseGecodeInfo,placemark,error) -> Void in
                
                if(error != nil){
                    
                    println(error)
                }else{
                    
                    println(reverseGecodeInfo!)
                    dispatch_async(dispatch_get_main_queue()) {
                        self.addressField.text = reverseGecodeInfo!.valueForKey("formattedAddress") as? String
                    }
                }
                
            }
        }
    }
    
    @IBAction func addLocation() {
        
        var dict = [String:String]()
        dict["uid"] = NSUserDefaults.standardUserDefaults().stringForKey("uid")
        dict["verificationCode"] = NSUserDefaults.standardUserDefaults().stringForKey("verificationCode")
        dict["latitude"] = "\(latitude)"
        dict["longitude"] = "\(longitude)"
        dict["address"] = addressField.text
        
        let service = TestUserService()
        service.addLocation(dict) {
            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
            
            if error != nil {
                displayAlert("Add Location - Connection Error", error!)
            } else if checkErrorCodeInDictionary(result!) {
                displayAlert("Success", "User Information Updated")
                
            }
        }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddedLocation"{
            let vc = segue.destinationViewController as? UserLocationsTVC

        }
    }
    */

}
