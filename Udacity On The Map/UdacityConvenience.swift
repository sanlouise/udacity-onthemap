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
    
    /* Normally, with other API's, In order for users to authenticate, the following steps need to be handled in this exact order.
    (1) Get request token.
    (2) Login with the API.
    (3) Create a Session ID.
    (4) Get the user ID.
    (5) Go the next view.
    With this API, however, we only need the Session ID.
    
    */
    
    //Login authentication with via Udacity
    
    func authenticateLoginWithViewController(parameters: [String : AnyObject], completionHandler: (success: Bool, error: NSError?) -> Void){
        getSessionID(parameters) { success, sessionID, UserID, error in
            if success {
                self.sessionID = sessionID
                print(UserID)
                completionHandler(success: true, error: nil)
            } else {
                
                completionHandler(success: false, error: error)
            }
        }
        
    }

    /* Get the Session ID for the user */
    func getSessionID(parameters: [String : AnyObject]?, completionHandler: (success: Bool, sessionID: String?, userKey: String?, error: NSError?) -> Void) {
        /* Check for success */
        
        
        taskForPOSTMethod(UdacityClient.Methods.Session, parameters: parameters!) { JSONResult, error in
            if let error = error {
                
                completionHandler(success: false, sessionID: nil, userKey: nil, error: error)
                
            } else {

                if let session = JSONResult.valueForKey(UdacityCLient.JSONResponseKeys.Session) {
                    
                    if let sessionID = session.valueForKey(UdacityClient.JSONResponseKeys.SessionID) as? String {
                        
                        if let account = JSONResult[UdacityClient.JSONResponseKeys.Account]  {
                            
                            if let IDKey = account![UdacityClient.JSONResponseKeys.IDKey] as? String {
                                
                                completionHandler(success: true, sessionID: sessionID, userKey: IDKey, error: nil)
                                
                            }
                        }
                    }
                }
            }
        }
    }

    
    func getUserID(jsonBody: [String : AnyObject], completionHandler: (userID: String?, error: NSError?) -> Void) {
        let task = self.taskForPOSTMethod(UdacityClient.Methods.Session, jsonBody: jsonBody) { JSONResult, error in

            if let error = error {
                completionHandler(userID: nil, error: NSError(domain: "getUserID", code: 0, userInfo: [NSLocalizedDescriptionKey: "Network Error"]))
                
            } else {
                
                if let statusCode = JSONResult.valueForKey(JSONResponseKeys.StatusCode) as? Int {
                    if statusCode == 403 {
                        let udacityError = JSONResult.valueForKey(JSONResponseKeys.Error) as! String
                        completionHandler(userID: nil, error: NSError(domain: "getUserID", code: 1, userInfo: [NSLocalizedDescriptionKey: udacityError]))
                    }
                    
                } else {
                    
                    if let account = JSONResult.valueForKey(JSONResponseKeys.Account) as? NSDictionary {
                        if let userID = account.valueForKey(JSONResponseKeys.Key) as? String {
                            completionHandler(userID: userID, error: nil)
                            
                        } else {
                            completionHandler(userID: nil, error: NSError(domain: "getUserID", code: 3, userInfo: [NSLocalizedDescriptionKey: "Could not parse userID as String"]))
                        }
                        
                    } else {
                        completionHandler(userID: nil, error: NSError(domain: "getUserID", code: 2, userInfo: [NSLocalizedDescriptionKey: "Could not parse account dictionary"]))
                    }
                }
            }
        }
    }
    
}
    