//
//  UserBankCardsTVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/3/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class UserBankCardsTVC: UITableViewController {

    var bankCards = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        getUserBankInfo()
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
        return bankCards.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserBankCardsTVCell", forIndexPath: indexPath) as! UserBankCardsTVCell

        var bankCard = bankCards[indexPath.row]
        cell.bankCardNumber.text = bankCard["bankCardNumber"] as? String
        cell.expirationDate.text = bankCard["expirationDate"] as? String
        cell.fullName.text = bankCard["fullName"] as? String
        cell.cvv.text = bankCard["cvv"] as? String
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
            bankCards.removeAtIndex(indexPath.row)
            
            // also need to delete from the server)
            
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    func getUserBankInfo() {
        var dict = [String:String]()
        dict["uid"] = NSUserDefaults.standardUserDefaults().stringForKey("uid")
        dict["verificationCode"] = NSUserDefaults.standardUserDefaults().stringForKey("verificationCode")
        
        let service = TestUserService()
        service.getUserBankInfo(dict) {
            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
            
            println(result!)
            
            if error != nil {
                displayAlert("Get User Info - Connection Error", error!)
            } else if checkErrorCodeInDictionary(result!) {
                self.bankCards = (result!["data"] as? [[String:AnyObject]])!
                self.tableView.reloadData()
            }
            
        }
    }

    @IBAction func addBankCard(sender: UIBarButtonItem) {
        var alertController = UIAlertController(
            title: "Add Bank Card",
            message: "Please enter your card information",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        var okAction = UIAlertAction(
            title: "OK", style: UIAlertActionStyle.Default) {
                (action) -> Void in
                
                var dict = [String:String]()
                dict["uid"] = NSUserDefaults.standardUserDefaults().stringForKey("uid")
                dict["verificationCode"] = NSUserDefaults.standardUserDefaults().stringForKey("verificationCode")
                dict["fullName"] = (alertController.textFields?[0] as! UITextField).text
                dict["bankCardNumber"] = (alertController.textFields?[1] as! UITextField).text
                dict["expirationDate"] = (alertController.textFields?[2] as! UITextField).text
                dict["cvv"] = (alertController.textFields?[3] as! UITextField).text
                
                let service = TestUserService()
                service.addBankCard(dict) {
                    (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
                    
                    if error != nil {
                        displayAlert("Add Location - Connection Error", error!)
                    } else if checkErrorCodeInDictionary(result!) {
                        displayAlert("Success", "User bank card added")
                        
                    }
                }
        }
        
        var cancelAction = UIAlertAction(
            title: "Cancel", style: UIAlertActionStyle.Cancel) {
                (action) -> Void in
                println("Add Bank Card Cancelled")
        }
        
        alertController.addTextFieldWithConfigurationHandler {
            (fullName) -> Void in
            fullName.placeholder = "<Your name here>"
        }
        
        alertController.addTextFieldWithConfigurationHandler {
            (bankCardNumber) -> Void in
            bankCardNumber.placeholder = "<Your bankCardNumber here>"
        }
        
        alertController.addTextFieldWithConfigurationHandler {
            (expirationDate) -> Void in
            expirationDate.placeholder = "<Your expirationDate here>"
        }
        
        alertController.addTextFieldWithConfigurationHandler {
            (cvv) -> Void in
            cvv.placeholder = "<Your cvv here>"
        }
        
        alertController.addAction(okAction)
        
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    
}
