//
//  UserLocationsTVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/3/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit
import MapKit

class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
}

class UserLocationsTVC: UITableViewController, MKMapViewDelegate, UITableViewDelegate {
    
    private struct address {
        var street: String?
        var city: String?
        var state: String?
        var country: String?
        var post: Int?
        var latitude: Double?
        var longitude: Double?
    }
    
    private var address1 = address(street: "Apple Inc., Infinite Loop", city: "Cupertino", state: "CA", country: "USA", post: 95014, latitude: 37.3320951, longitude: -122.0307425)
    private var address2 = address(street: "14055 Chester Ave", city: "Saratoga", state: "CA", country: "USA", post: 95070, latitude: 37.264462, longitude: -122.001732)
    private var address3 = address(street: "14055 Chester Ave", city: "Saratoga", state: "CA", country: "USA", post: 95070, latitude: 37.264462, longitude: -122.001732)
    
    private var addresses = [address]()
    
    private var checkedIndexPath : NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addresses = [address1, address2, address3]
        
        // hide seperator below each cell
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // set top margin of table view
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        title = "Addresses"
        tableView.reloadData()
    }
    
    // MARK: - TableView Delegates
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserLocationsTVCell", forIndexPath: indexPath) as! UserLocationsTVCell
        
        
        
        var cellAddress = addresses[indexPath.row]
        cell.streetLabel.text = cellAddress.street
        cell.cityLabel.text = cellAddress.city
        cell.stateLabel.text = cellAddress.state
        cell.countryLabel.text = cellAddress.country
        cell.postLabel.text = "\(cellAddress.post!)"
        
        cell.map.delegate = self
        
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: cellAddress.latitude!, longitude: cellAddress.longitude!)
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius * 2.0, regionRadius * 2.0)
        cell.map.setRegion(coordinateRegion, animated: true)
        
        /* display annotation in middle
        var annotation = CustomPointAnnotation()
        annotation.coordinate = location
        annotation.imageName = "map pin.png"
        cell.map.addAnnotation(annotation)
        */
        cell.map.showsUserLocation = true
        
        /* encontered a problem where only the last map got updated
        var locationManager = LocationManager.sharedInstance
        let addressString = "\(cellAddress.street), \(cellAddress.city), \(cellAddress.state) \(cellAddress.post), \(cellAddress.country)"
        locationManager.geocodeAddressString(address: addressString) {
            (geocodeInfo,placemark,error) -> Void in
            
            if(error != nil) {
                println(error)
            } else {
                print(geocodeInfo!)
                let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Double((geocodeInfo!["latitude"]! as! NSString).doubleValue), longitude: Double((geocodeInfo!["longitude"]! as! NSString).doubleValue))
                let regionRadius: CLLocationDistance = 1000
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius * 2.0, regionRadius * 2.0)
                cell.map.setRegion(coordinateRegion, animated: true)
            }
        }
        */
        
        cell.selectionStyle = .None
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (self.checkedIndexPath != nil) {
            if let var cell = tableView.cellForRowAtIndexPath(self.checkedIndexPath!) as? UserLocationsTVCell {
                fadeOutView(cell.defaultIndicator, 0.35)
            }
            
        }
        
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! UserLocationsTVCell
        fadeInView(cell.defaultIndicator, 0.35)
        
        self.checkedIndexPath = indexPath
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // Delete the row from the data source
            addresses.removeAtIndex(indexPath.row)
            
            // also need to delete from the server)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
    }
    
    // Customize annotation appearance
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if !(annotation is CustomPointAnnotation) {
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView.canShowCallout = true
        }
        else {
            anView.annotation = annotation
        }
        
        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...
        
        let cpa = annotation as! CustomPointAnnotation
        anView.image = UIImage(named:cpa.imageName)
        
        return anView
    }

    // MARK: - Navigation
    
    
    @IBAction func dismissScene(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    /*
    var locations = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        getUserLocationInfo()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return locations.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserLocationsTVCell", forIndexPath: indexPath) as! UserLocationsTVCell
        
        var location = locations[indexPath.row]
        cell.addressLabel.text = location["address"] as? String
        
        var latitude: CLLocationDegrees = (location["latitude"] as! NSString).doubleValue
        var longitude: CLLocationDegrees = (location["longitude"] as! NSString).doubleValue
        var latDelta: CLLocationDegrees = 0.01
        var lonDelta: CLLocationDegrees = 0.01
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var locationn: CLLocationCoordinate2D = CLLocationCoordinate2DMake(40.7, -73.9)
        var region: MKCoordinateRegion = MKCoordinateRegionMake(locationn, span)
        
        cell.map.setRegion(region, animated: true)

        return cell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            locations.removeAtIndex(indexPath.row)
            
            // also need to delete from the server
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
    

    @IBAction func addNewLocation(sender: UIBarButtonItem) {
        
    }

    func getUserLocationInfo() {
        var dict = [String:String]()
        dict["uid"] = NSUserDefaults.standardUserDefaults().stringForKey("uid")
        dict["verificationCode"] = NSUserDefaults.standardUserDefaults().stringForKey("verificationCode")
        
        let service = TestUserService()
        service.getUserLocationInfo(dict) {
            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
            
            println(result!)
            
            if error != nil {
                displayAlert("Get User Info - Connection Error", error!)
            } else if checkErrorCodeInDictionary(result!) {
                self.locations = (result!["data"] as? [[String:AnyObject]])!
                self.tableView.reloadData()
            }
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    */


}
