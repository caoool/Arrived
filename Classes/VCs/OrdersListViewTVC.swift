//
//  OrdersListViewTVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/29/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit
import MapKit

class OrdersListViewTVC: UITableViewController {

    
    private var testOrders = [Order]()
    
    // for user location
    var manager: CLLocationManager!
    var myLocations: [CLLocation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let order1 = Order(requestId: 1, phoneNumber: 13304650123, nickname: "Sam", portrait: "http://i.imgur.com/YrbaaFr.png", price: 133, title: "I am Order 1", body: "In SCU ENGINEER 1st Floor bathroom, help", effectiveStartDate: "21/06/2015, 12:23:00", effectiveEndDate: "21/06/2015, 12:33:00", tags: "", latitude: 37.34235200, longitude: -122.0322302, address: "rain st.123", status: "regular")
        let order2 = Order(requestId: 1, phoneNumber: 13304650123, nickname: "Sam", portrait: "http://i.imgur.com/YrbaaFr.png", price: 133, title: "Who can tell I am order 2", body: "In SCU ENGINEER 1st Floor bathroom, help", effectiveStartDate: "21/06/2015, 12:23:00", effectiveEndDate: "21/06/2015, 12:33:00", tags: "", latitude: 37.37235141, longitude: -122.0342182, address: "rain st.123", status: "interested")
        let order3 = Order(requestId: 1, phoneNumber: 13304650123, nickname: "Sam", portrait: "http://i.imgur.com/YrbaaFr.png", price: 133, title: "These two fuckers are order 1 and 2", body: "In SCU ENGINEER 1st Floor bathroom, help", effectiveStartDate: "21/06/2015, 12:23:00", effectiveEndDate: "21/06/2015, 12:33:00", tags: "", latitude: 37.31235141, longitude: -122.0112182, address: "rain st.123", status: "in progress")
        testOrders = [order1, order2, order3]
        
        // hide seperator below each cell
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // set top margin of table view
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        self.tableView.backgroundColor = UIColor(red:0.95, green:0.69, blue:0.25, alpha:0.06)

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
        return testOrders.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OrdersListViewTVCell", forIndexPath: indexPath) as! OrdersListViewTVCell
        
        cell.selectionStyle = .None

        ImageLoader.sharedLoader.imageForUrl(self.testOrders[indexPath.row].portrait!, completionHandler:{(image: UIImage?, url: String) in
            cell.portrait.image = image!
        })
        cell.titleLabel.text = testOrders[indexPath.row].title
        cell.priceLabel.text = "$ \(testOrders[indexPath.row].price!)"
        
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
            
            let latitude = manager.location.coordinate.latitude
            let longitude = manager.location.coordinate.longitude
            let location = CLLocation(latitude: latitude, longitude: longitude)

            let newLatitude = testOrders[indexPath.row].latitude!
            let newLongitude = testOrders[indexPath.row].longitude!
            let newLocation = CLLocation(latitude: newLatitude, longitude: newLongitude)
            
            cell.distanceLabel.text = "\(Int((location.distanceFromLocation(newLocation))/1000)) miles"
            
            switch testOrders[indexPath.row].status! {
            case "regular":
                cell.status.image = UIImage(named: "")
            case "interested":
                cell.status.image = UIImage(named: "interested indicator")
            case "in progress":
                cell.status.image = UIImage(named: "processing indicator")
            default:
                break
            }
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?  {

        var shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Interested" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            self.tableView.setEditing(false, animated: false)
        })

        return [shareAction]
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Functionalities

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
