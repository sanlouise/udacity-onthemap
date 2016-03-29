//
//  UdacityClient.swift
//  Udacity On The Map
//
//  Created by Sandra Adams-Hallie on Mar/29/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit

class UdacityClient: NSObject {
    // List session variables
    var session: NSURLSession
    var IDKey: String? = nil
    var sessionID: String? = nil
    var latitude: Double? = nil
    var longitude: Double? = nil
    var mapString: String? = nil
    var imageURL: String? = nil
    
    
    // Use the NSURlSession:
    override init() {
        session = NSURLSession.sharedSession()
        super.init()
    }
}

