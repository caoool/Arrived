
//
//  OrdersMapViewVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/28/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit
import MapKit

class OrdersMapViewVC: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var detailView: UIView!
    
    // detail view
    @IBOutlet weak var portraitImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var interestView: UIView!
    @IBOutlet weak var progressingView: UIView!
    
    private var testOrders = [Order]()
    private var currentOrderIndex = 0
    
    private var annotations = [CustomPointAnnotation]()
    
    // for user location
    var manager: CLLocationManager!
    var myLocations: [CLLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let order1 = Order(requestId: 1, phoneNumber: 13304650123, nickname: "Sam", portrait: "http://i.imgur.com/YrbaaFr.png", price: 133, title: "I am Order 1", body: "In SCU ENGINEER 1st Floor bathroom, help", effectiveStartDate: "21/06/2015, 12:23:00", effectiveEndDate: "21/06/2015, 12:33:00", tags: "", latitude: 37.34235200, longitude: -122.0322302, address: "rain st.123", status: "regular")
        let order2 = Order(requestId: 1, phoneNumber: 13304650123, nickname: "Sam", portrait: "http://i.imgur.com/YrbaaFr.png", price: 133, title: "Who can tell I am order 2", body: "In SCU ENGINEER 1st Floor bathroom, help", effectiveStartDate: "21/06/2015, 12:23:00", effectiveEndDate: "21/06/2015, 12:33:00", tags: "", latitude: 37.37235141, longitude: -122.0342182, address: "rain st.123", status: "interested")
        let order3 = Order(requestId: 1, phoneNumber: 13304650123, nickname: "Sam", portrait: "http://i.imgur.com/YrbaaFr.png", price: 133, title: "These two fuckers are order 1 and 2", body: "In SCU ENGINEER 1st Floor bathroom, help", effectiveStartDate: "21/06/2015, 12:23:00", effectiveEndDate: "21/06/2015, 12:33:00", tags: "", latitude: 37.31235141, longitude: -122.0112182, address: "rain st.123", status: "in progress")
        testOrders = [order1, order2, order3]
        
        loadScene()
    }
    
    func loadScene() {
        
        initMapCenter()
        
        if testOrders.count > 0 {
            addAnnotations()
            setDetailView()
            goToOrder(currentOrderIndex)
        }
        
        addSwipeGesturesToDetailView()
    }
    
    func reloadScene() {
        mapView.removeAnnotations(mapView.annotations)
        
        if testOrders.count > 0 {
            addAnnotations()
            setDetailView()
            goToOrder(currentOrderIndex)
        }
    }
    
    func setDetailView() {
        detailView.layer.borderWidth = 0.3
        detailView.layer.borderColor = UIColor.lightGrayColor().CGColor
        detailView.layer.cornerRadius = 12
        detailView.alpha = 0.9
        
        interestView.layer.borderWidth = 0.3
        interestView.layer.borderColor = UIColor.lightGrayColor().CGColor
        interestView.layer.cornerRadius = 12
        interestView.alpha = 0.9
        
        interestView.alpha = 0
        
        progressingView.layer.borderWidth = 0.3
        progressingView.layer.borderColor = UIColor.lightGrayColor().CGColor
        progressingView.layer.cornerRadius = 12
        progressingView.alpha = 0.9
        
        progressingView.alpha = 0
        
    }
    
    func initMapCenter() {
        
        mapView.delegate = self
        
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
            
            let latitude = manager.location.coordinate.latitude
            let longitude = manager.location.coordinate.longitude
            let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let regionRadius: CLLocationDistance = 10000
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius * 2.0, regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }

    }
    
    func addAnnotations() {
        for order in testOrders {
            let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: order.latitude!, longitude: order.longitude!)
            var annotation = CustomPointAnnotation()
            annotation.coordinate = location
            switch order.status! {
            case "regular":
                annotation.imageName = "regular pin"
            case "interested":
                annotation.imageName = "interested pin"
            case "in progress":
                annotation.imageName = "in progress pin"
            default:
                break
            }
            
            mapView.addAnnotation(annotation)
            annotations.append(annotation)
        }
    }
    
    func goToOrder(i: Int) {
        setDetailViewContent(i)
        centerMapOnOrder(i)
    }
    
    
    func setDetailViewContent(i: Int) {
        dispatch_async(dispatch_get_main_queue()) {
            ImageLoader.sharedLoader.imageForUrl(self.testOrders[i].portrait!, completionHandler:{(image: UIImage?, url: String) in
                self.portraitImage.image = image!
            })
        }
        titleLabel.text = testOrders[i].title
        priceLabel.text = "$ \(testOrders[i].price!)"
        priceLabel.layer.backgroundColor = UIColorFromHex(0x000000, alpha: 0.02).CGColor
        
        hideAndShowStatusViews(testOrders[i].status!)
    }
    
    func centerMapOnOrder(i: Int) {
        let latitude = manager.location.coordinate.latitude
        let longitude = manager.location.coordinate.longitude
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: testOrders[i].latitude!, longitude: testOrders[i].longitude!)
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func fadeAndChangeDetailViewContent(i: Int) {
        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.detailView.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                
                self.goToOrder(i)
                
                // Fade in
                UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    self.detailView.alpha = 1.0
                    }, completion: nil)
        })
    }
    
    func hideAndShowStatusViews(status: String) {
        switch status {
        case "regular":
            fadeOutView(interestView, 0.2)
            fadeOutView(progressingView, 0.2)
        case "interested":
            UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.progressingView.alpha = 0.0
                }, completion: {
                    (finished: Bool) -> Void in
                    
                    // Fade in
                    UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                        self.interestView.alpha = 1.0
                        }, completion: nil)
            })
        case "in progress":
            UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.interestView.alpha = 0.0
                }, completion: {
                    (finished: Bool) -> Void in
                    
                    // Fade in
                    UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                        self.progressingView.alpha = 1.0
                        }, completion: nil)
            })
        default:
            break
        }
    }
    
    // MARK: - User Interaction
    func addSwipeGesturesToDetailView() {
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        detailView.addGestureRecognizer(swipeRight)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        detailView.addGestureRecognizer(swipeLeft)
        
        var swipeUp = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        detailView.addGestureRecognizer(swipeUp)
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        detailView.addGestureRecognizer(swipeDown)
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                if currentOrderIndex == 0 {
                    fadeAndChangeDetailViewContent(testOrders.count - 1)
                    currentOrderIndex = testOrders.count - 1
                } else {
                    fadeAndChangeDetailViewContent(--currentOrderIndex)
                }

            case UISwipeGestureRecognizerDirection.Left:
                if currentOrderIndex == testOrders.count - 1 {
                    fadeAndChangeDetailViewContent(0)
                    currentOrderIndex = 0
                } else {
                    fadeAndChangeDetailViewContent(++currentOrderIndex)
                }

            case UISwipeGestureRecognizerDirection.Up:
                if testOrders[currentOrderIndex].status == "regular" {
                    fadeInView(interestView, 0.6)
                    bounceView(interestView)
                    testOrders[currentOrderIndex].status = "interested"
                    mapView.removeAnnotation(annotations[currentOrderIndex])
                    annotations[currentOrderIndex].imageName = "interested pin"
                    mapView.addAnnotation(annotations[currentOrderIndex])
                } else if testOrders[currentOrderIndex].status == "interested" {
                    fadeOutView(interestView, 0.6)
                    bounceView(interestView)
                    testOrders[currentOrderIndex].status = "regular"
                    mapView.removeAnnotation(annotations[currentOrderIndex])
                    annotations[currentOrderIndex].imageName = "regular pin"
                    mapView.addAnnotation(annotations[currentOrderIndex])
                }
                
            case UISwipeGestureRecognizerDirection.Down:
                // TODO: - Something like refresh
                break
            default:
                break
            }
        }
    }
    
    // MARK: - Delegates
    
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
    @IBAction func goToDetailView(sender: UIButton) {
        performSegueWithIdentifier("OrdersMapViewToOrderDetailView", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "OrdersMapViewToOrderDetailView" {
            var svc = segue.destinationViewController as! OrderDetailVC;
            svc.toPass = testOrders[currentOrderIndex]
        }
    }
    
    

}
