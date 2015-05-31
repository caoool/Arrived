//
//  MyOrdersRequestsTVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/31/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class MyOrdersRequestsTVC: UITableViewController {

    var testOrders = [Order]()
    var selectedOrder = Order()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTestData()

        tableView.backgroundColor = UIColorFromHex(0xFFFFFF, alpha: 0)
        
        // hide seperator below each cell
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
    }

    func createTestData() {
        let order1 = Order(requestId: 1, phoneNumber: 13304650123, nickname: "Sam", portrait: "http://i.imgur.com/YrbaaFr.png", price: 133, title: "I am Order 1", body: "In SCU ENGINEER 1st Floor bathroom, help", effectiveStartDate: "21/06/2015, 12:23:00", effectiveEndDate: "21/06/2015, 12:33:00", tags: "", latitude: 37.34235200, longitude: -122.0322302, address: "rain st.123", status: "regular")
        let order2 = Order(requestId: 1, phoneNumber: 13304650123, nickname: "Sam", portrait: "http://i.imgur.com/YrbaaFr.png", price: 133, title: "Who can tell I am order 2", body: "In SCU ENGINEER 1st Floor bathroom, help", effectiveStartDate: "21/06/2015, 12:23:00", effectiveEndDate: "21/06/2015, 12:33:00", tags: "", latitude: 37.37235141, longitude: -122.0342182, address: "rain st.123", status: "interested")
        let order3 = Order(requestId: 1, phoneNumber: 13304650123, nickname: "Sam", portrait: "http://i.imgur.com/YrbaaFr.png", price: 133, title: "These two fuckers are order 1 and 2", body: "In SCU ENGINEER 1st Floor bathroom, help", effectiveStartDate: "21/06/2015, 12:23:00", effectiveEndDate: "21/06/2015, 12:33:00", tags: "", latitude: 37.31235141, longitude: -122.0112182, address: "rain st.123", status: "in progress")
        testOrders = [order1, order2, order3]
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
        let cell = tableView.dequeueReusableCellWithIdentifier("MyOrdersRequestsTVCell", forIndexPath: indexPath) as! MyOrdersRequestsTVCell

        cell.titleLabel.text = testOrders[indexPath.row].title
        if testOrders[indexPath.row].status! == "in progress" {
            cell.takersButton.setTitle("", forState: .Normal)
            cell.takersButton.setImage(UIImage(named: "progressing icon"), forState: .Normal)
            cell.takersButton.backgroundColor = UIColor.clearColor()
            cell.takersButton.addTarget(self, action: "showProgress", forControlEvents: .TouchUpInside)
        } else {
            cell.takersButton.addTarget(self, action: "showTakers", forControlEvents: .TouchUpInside)
        }
        
        cell.selectionStyle = .None
        cell.alpha = 0.9
        return cell
    }
    
    func showProgress() {
        performSegueWithIdentifier("RequestShowProgress", sender: self)
    }
    
    func showTakers() {
        performSegueWithIdentifier("RequestShowTakers", sender: self)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyOrdersRequestsTVCell", forIndexPath: indexPath) as! MyOrdersRequestsTVCell
        
        selectedOrder = testOrders[indexPath.row]
        performSegueWithIdentifier("RequestDetail", sender: self)
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
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "RequestDetail" {
            var svc = segue.destinationViewController as! MyOrdersRequestViewDetailVC
            svc.toPass = selectedOrder
        }
        if segue.identifier == "RequestShowTakers" {
            var svc = segue.destinationViewController as! MyOrdersRequestsShowTakerTVC
            svc.toPass = selectedOrder
        }
        
    }

}
