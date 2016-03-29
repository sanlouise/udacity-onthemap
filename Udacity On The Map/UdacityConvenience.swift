//
//  UdacityConvenience.swift
//  Udacity On The Map
//
//  Created by Sandra Adams-Hallie on Mar/29/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit
import Foundation

extension UdacityClient {
    
    //Login authentication with via Udacity
    func authenticateLoginWithViewController(hostViewController: LoginViewController, completionHandler: (success: Bool, errorString: String?) -> Void) {
        
//        let networkReachability = Reachability.reachabilityForInternetConnection()
//        let networkStatus = networkReachability.currentReachabilityStatus()
        
        if(hostViewController.emailTextField.text != nil && hostViewController.passwordTextField != nil){
//            if(networkStatus.rawValue != NotReachable.rawValue){// Before quering fοr an existing location check if there is an available internet connection
//                hostViewController.indicator(true)
                getSessionID( hostViewController.emailTextField.text! , password: hostViewController.passwordTextField.text!) { result, errorString in
                    if (result != nil) {
                        self.getPublicUserData(self.uniqueKey!)  { account,errorString in
                            if account != nil{
                                completionHandler(success: true, errorString: nil)
                            }
                        }
                    } else {
                        dispatch_async(dispatch_get_main_queue(), {
//                            hostViewController.indicator(false)
                            completionHandler(success: false, errorString: "Wrong Username or Password")
                        })
                    }
                }
            }else{
//                hostViewController.indicator(false)
                completionHandler(success: false, errorString: "No Network Connection Found")
            }
        }
    }

    //Retrieves session ID for Udacity.
    func getSessionID(email: String, password: String, completionHandler: (result: String?, error: NSError?) -> Void) {
        
        // 1. Specify parameters
        let mutableMethod : String = Methods.AuthenticationSessionNew
        let udacityBody: [String:AnyObject] = [UdacityClient.JSONBody.Email: email, UdacityClient.JSONBody.Password : password ]
        let jsonBody : [String:AnyObject] = [ UdacityClient.JSONBody.Udacity: udacityBody ]
        
        // 2. Make the request
        _ = taskForPOSTMethod(mutableMethod,parse:false, parameters: nil , jsonBody: jsonBody) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                if let results = JSONResult.valueForKey(UdacityClient.JSONResponseKeys.Session)?.valueForKey(UdacityClient.JSONResponseKeys.Id) as? String {
                    self.sessionID = results // Setting the session ID
                    if let key = JSONResult.valueForKey(UdacityClient.JSONResponseKeys.Account)?.valueForKey(UdacityClient.JSONResponseKeys.Key) as? String{
                        self.uniqueKey = key
                    }
                    completionHandler(result: results, error: nil)
                } else {
                    completionHandler(result: nil, error: NSError(domain: "postToSession parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postToSession"]))
                }
            }
        }
        
    }




}
    