//
//  UdacityClient.swift
//  Udacity On The Map
//
//  Created by Sandra Adams-Hallie on Mar/29/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit
import UIKit

class UdacityClient: NSObject {
    
    var session: NSURLSession
    
    var sessionID: String?
    var uniqueKey: String?
    var account: Student?
    var students: [Student]?
    
    override init(){
        session = NSURLSession.sharedSession()
        super.init()
    }
    
    // MARK: GET
    
    func taskForGETMethod(method: String, var parameters: [String:AnyObject], completionHandlerForGET: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        /* 1. Set the parameters */
        var urlString:String
        if let mutableParameters = parameters {
            urlString = method + UdacityClient.escapedParameters(mutableParameters)
        }else{
            urlString = method
        }
        
        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(URL: tmdbURLFromParameters(parameters, withPathExtension: method))
        
        /* 4. Make the request */
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(result: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    // MARK: Helpers
    
    // substitute the key for the value that is contained within the method name
    func subtituteKeyInMethod(method: String, key: String, value: String) -> String? {
        if method.rangeOfString("{\(key)}") != nil {
            return method.stringByReplacingOccurrencesOfString("{\(key)}", withString: value)
        } else {
            return nil
        }
    }
    
    // given raw JSON, return a usable Foundation object
    private func convertDataWithCompletionHandler(data: NSData, completionHandlerForConvertData: (result: AnyObject!, error: NSError?) -> Void) {
        
        var parsedResult: AnyObject!
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(result: nil, error: NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(result: parsedResult, error: nil)
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
    
//    // create a URL from parameters
//    private func tmdbURLFromParameters(parameters: [String:AnyObject], withPathExtension: String? = nil) -> NSURL {
//        
//        let components = NSURLComponents()
//        components.scheme = UdacityClient.Constants.ApiScheme
//        components.host = UdacityClient.Constants.ApiHost
//        components.path = UdacityClient.Constants.ApiPath + (withPathExtension ?? "")
//        components.queryItems = [NSURLQueryItem]()
//        
//        for (key, value) in parameters {
//            let queryItem = NSURLQueryItem(name: key, value: "\(value)")
//            components.queryItems!.append(queryItem)
//        }
//        
//        return components.URL!
//    }


    
    
    
    
}

