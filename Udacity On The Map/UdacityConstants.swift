//
//  UdacityConstants.swift
//  Udacity On The Map
//
//  Created by Sandra Adams-Hallie on Mar/29/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//


extension UdacityClient{
    
    struct Constants {
        static let BaseURLSecure = "https://www.udacity.com/api/"
    }
 
    struct Methods {
        static let Session = "session"
        static let GetUserData = "users/{id}"
    }
        
    // MARK: - JSON Response Keys
    struct JSONResponseKeys {
        
        static let Session = "session"
        static let Account = "account"
        static let Key = "key"
        static let ID = "id"
        static let User = "user"
        static let Last_Name = "last_name"
        static let First_Name = "first_name"
        static let Results = "results"
        static let ObjectID = "objectId"
        
        // MARK: Authorization
        static let SessionID = "session_id"
        
        // MARK: Account
        static let UserID = "id"
        static let AccessToken = "access_token"
        
    }
    
    struct JSONBody{
        // MARK: Body for POST
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
        static let objectId = "objectId"
        static let uniqueKey = "uniqueKey"
        static let firstName = "firstName"
        static let lastName = "lastName"
    }
}
