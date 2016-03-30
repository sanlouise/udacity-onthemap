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
        getSessionID(parameters) { success, sessionID, IDKey, error in
            if success {
                
                self.sessionID = sessionID
                self.UserID = UserID
                print(IDKey)
                completionHandler(success: true, error: nil)
            } else {
                
                completionHandler(success: false, error: error)
            }
        }
        
    }


    /* Get the Session ID for the user */
    func getSessionID(parameters: [String : AnyObject]?, completionHandler: (success: Bool, sessionID: String?, userKey: String?, error: NSError?) -> Void) {
        /* Check for success */
        
        
        taskForPOSTMethod(UdaciousClient.Methods.Session, parameters: parameters!) { JSONResult, error in
            if let error = error {
                
                completionHandler(success: false, sessionID: nil, userKey: nil, error: error)
                
            } else {
                /* Attempt to get the session ID */
                if let session = JSONResult.valueForKey(UdaciousClient.JSONResponseKeys.Session) {
                    
                    if let sessionID = session.valueForKey(UdaciousClient.JSONResponseKeys.SessionID) as? String {
                        
                        /* get the account and user from JSONResult */
                        if let account = JSONResult[UdaciousClient.JSONResponseKeys.Account]  {
                            
                            if let IDKey = account![UdaciousClient.JSONResponseKeys.IDKey] as? String {
                                
                                completionHandler(success: true, sessionID: sessionID, userKey: IDKey, error: nil)
                                
                            }
                        }
                    }
                }
            }
        }
    }



}
    