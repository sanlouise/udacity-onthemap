//
//  Reachability.swift
//  Udacity On The Map
//
//  Created by Sandra Adams-Hallie on Mar/29/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

//stackoverflow.com/questions/25398664/check-for-internet-connection-availability-in-swift//

//import Foundation
//import SystemConfiguration
//
//public class Reachability {
//    
//    class func isConnectedToNetwork() -> Bool {
//        
//        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
//        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//        
//        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
//            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0)).takeRetainedValue()
//        }
//        
//        var flags: SCNetworkReachabilityFlags = 0
//        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == 0 {
//            return false
//        }
//        
//        let isReachable = (flags & UInt32(kSCNetworkFlagsReachable)) != 0
//        let needsConnection = (flags & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
//        
//        return (isReachable && !needsConnection) ? true : false
//    }
//    
//}
