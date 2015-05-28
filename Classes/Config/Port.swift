//
//  Port.swift
//  Arrived
//
//  Created by Yetian Mao on 5/26/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import Foundation

class Port {
    
    static var url = "http://arrived.xyz/api/v1"
    
    
    
    var login_get = "\(url)/users/getCode"
    var login_auth = "\(url)/users/auth"
    
    var user_getOne = "\(url)/users/getUserInfo"
    var user_update = "\(url)/users/update"
    
    var bank_add = "\(url)/users/addBankCard"
    var bank_get = "\(url)/users/getUserBankInfo"
    var bank_delete = "\(url)/bank/delete"
    
    var location_add = "\(url)/users/addLocation"
    var location_get = "\(url)/users/getUserLocationInfo"
    
    //Asker
    var request_post = "\(url)/requests/post"
    var request_takers = "\(url)/requests/takers"
    var request_pick = "\(url)/requests/pick"
    //Taker
    var request_jobs = "\(url)/requests/jobs"
    var request_interested = "\(url)/requests/interested"
    var request_notInterested = "\(url)/requests/notInterested"
    
    var request_accepted = "\(url)/requests/accepted"
    var request_finished = "\(url)/requests/finished"

    var review_post = "\(url)/reviews/post"
    var review_delete = "\(url)/reviews/delete"
    var review_get = "\(url)/reviews/get"
    
    
    
    
}