//
//  User.swift
//  Arrived
//
//  Created by Lu Cao on 5/2/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import Foundation



class User {
    
    struct bankCard {
        private var bankCardId: String
        private var fullName: String
        private var bankCardNumber: String
        private var expirationDate: String
        private var cvv: String
    }
    
    private var bankCards = [bankCard]()
    

}
