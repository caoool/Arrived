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
    
    private var testOrders = [Order]()
    
    // for user location
    var manager: CLLocationManager!
    var myLocations: [CLLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let order1 = Order(requestId: 1, phoneNumber: 13304650123, nickname: "Sam", portrait: "http://i.imgur.com/YrbaaFr.png", price: 133, title: "help, need toilet paper", body: "In SCU ENGINEER 1st Floor bathroom, help", effectiveStartDate: "21/06/2015, 12:23:00", effectiveEndDate: "21/06/2015, 12:33:00", tags: "", latitude: 37.33235141, longitude: -122.0312182, address: "rain st.123")
        let order2 = Order(requestId: 1, phoneNumber: 13304650123, nickname: "Sam", portrait: "http://i.imgur.com/YrbaaFr.png", price: 133, title: "help, need toilet paper", body: "In SCU ENGINEER 1st Floor bathroom, help", effectiveStartDate: "21/06/2015, 12:23:00", effectiveEndDate: "21/06/2015, 12:33:00", tags: "", latitude: 37.33235141, longitude: -122.0312182, address: "rain st.123")
        let order3 = Order(requestId: 1, phoneNumber: 13304650123, nickname: "Sam", portrait: "http://i.imgur.com/YrbaaFr.png", price: 133, title: "help, need toilet paper", body: "In SCU ENGINEER 1st Floor bathroom, help", effectiveStartDate: "21/06/2015, 12:23:00", effectiveEndDate: "21/06/2015, 12:33:00", tags: "", latitude: 37.33235141, longitude: -122.0312182, address: "rain st.123")
        testOrders = [order1, order2, order3]
        
        initMapCenter()
    }
    
    func initMapCenter() {
        
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
            
            let latitude = manager.location.coordinate.latitude
            let longitude = manager.location.coordinate.longitude
            let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let regionRadius: CLLocationDistance = 1000
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius * 2.0, regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }

    }
    
    
    

}
