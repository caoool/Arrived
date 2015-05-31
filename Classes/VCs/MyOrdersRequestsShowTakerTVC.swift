//
//  MyOrdersRequestsShowTakerTVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/31/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class MyOrdersRequestsShowTakerTVC: UITableViewController {

    struct testData {
        var name: String?
        var line: String?
        var likes: Int?
        var dislikes: Int?
        var jobsDone: Int?
    }
    
    var testDataArray = [testData]()
    
    var toPass = Order()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTestData()
        
        initScene()
    }
    
    func setUpTestData() {
        var data1 = testData(name: "Luu", line: "We all love you", likes: 300, dislikes: 0, jobsDone: 500)
        var data2 = testData(name: "Fucker", line: "We all hate you", likes: 0, dislikes: 300, jobsDone: 0)
        var data3 = testData(name: "Mr Ordinary", line: "We all ignore you", likes: 0, dislikes: 0, jobsDone: 0)
        testDataArray = [data1, data2, data3]
    }

    func initScene() {
        
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        // add blur background
//        var bgBlurView = UIImageView()
//        bgBlurView.image = UIImage(named: "my portrait")
//        bgBlurView.frame = CGRectMake(-(tableView.frame.height - tableView.frame.width)/2, 0, tableView.frame.height, tableView.frame.height)
//        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
//        var blurView = UIVisualEffectView(effect: blurEffect)
//        blurView.frame = bgBlurView.bounds
//        bgBlurView.addSubview(blurView)
//        self.tableView.backgroundView = bgBlurView
        
        // hide seperator below each cell
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None

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
        return testDataArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyOrdersRequestsShowTakerTVCell", forIndexPath: indexPath) as! MyOrdersRequestsShowTakerTVCell

        cell.portrait.image = UIImage(named: "my portrait")
        cell.nickname.text = testDataArray[indexPath.row].name
        cell.status.text = testDataArray[indexPath.row].line
        cell.likes.text = "\(testDataArray[indexPath.row].likes!)"
        cell.dislikes.text = "\(testDataArray[indexPath.row].dislikes!)"
        cell.jobsDone.text = "\(testDataArray[indexPath.row].jobsDone!)"

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
