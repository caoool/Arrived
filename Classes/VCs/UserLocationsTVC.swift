//
//  UserLocationsTVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/3/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit
import MapKit

class UserLocationsTVC: UITableViewController, MKMapViewDelegate {
    
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
    

}
