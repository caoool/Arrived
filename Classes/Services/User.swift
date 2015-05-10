//
//  User.swift
//  Arrived
//
//  Created by Lu Cao on 5/2/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import Foundation



class User {
    
    struct location {
        private var locationId: String
        private var latitude: String
        private var longitude: String
        private var address: String
    }
    
    struct bankCard {
        private var bankCardId: String
        private var fullName: String
        private var bankCardNumber: String
        private var expirationDate: String
        private var cvv: String
    }
    
    private var locations = [location]?()
    private var bankCards = [bankCard]?()
    var id = 0
    

}
