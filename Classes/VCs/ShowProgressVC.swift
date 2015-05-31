//
//  ShowProgressVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/31/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit
import MapKit

class ShowProgressVC: UIViewController, MKMapViewDelegate {
    
    var isInitiated = false
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var actionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpScene()
    }

    func setUpScene() {
        
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        mapView.delegate = self
        
        // setup map latitude: 37.31235141, longitude: -122.0112182
        let latitude: Double = 37.31235141
        let longitude: Double = -122.0112182
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
        var annotation = CustomPointAnnotation()
        annotation.coordinate = location
        annotation.imageName = "regular pin"
        mapView.addAnnotation(annotation)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        if !isInitiated {
            isInitiated = !isInitiated
            
            bgView.layer.borderColor = UIColor.lightGrayColor().CGColor
            bgView.layer.borderWidth = 1.2
            bgView.layer.cornerRadius = 12
            
            priceLabel.layer.borderColor = UIColor.lightGrayColor().CGColor
            priceLabel.layer.borderWidth = 0.65
            priceLabel.layer.cornerRadius = priceLabel.frame.height/2
            priceLabel.alpha = 0.85
            
            contactButton.layer.borderColor = UIColor.lightGrayColor().CGColor
            contactButton.layer.borderWidth = 0.65
            contactButton.layer.cornerRadius = contactButton.frame.height/2
            priceLabel.alpha = 0.85
            
            actionButton.layer.borderColor = UIColor.lightGrayColor().CGColor
            actionButton.layer.borderWidth = 0.65
            actionButton.layer.cornerRadius = actionButton.frame.height/2
            actionButton.alpha = 0.85
//        }
    }
    
    @IBAction func actionTapped(sender: UIButton) {
        bounceView(actionButton)
    }
    
    @IBAction func contactTapped(sender: UIButton) {
        bounceView(contactButton)
        let alert = AlertController(title: "Contact", message: nil, style: .ActionSheet)
        showAlert(alert)
    }
    
    func showAlert(alert: SimpleAlert.Controller) {
        
        alert.addAction(SimpleAlert.Action(title: "Call", style: .Default) { action in
            })
        alert.addAction(SimpleAlert.Action(title: "Message", style: .Default) { action in
            })
        
        alert.addAction(SimpleAlert.Action(title: "Cancel", style: .Cancel) { action in
            })
        
        self.presentViewController(alert, animated: true, completion: nil)
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}




















