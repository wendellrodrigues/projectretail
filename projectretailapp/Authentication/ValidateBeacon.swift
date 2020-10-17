////
////  ValidateBeacon.swift
////  projectretailapp
////
////  Created by Wendell Rodrigues on 10/15/20.
////  Copyright © 2020 Wendell. All rights reserved.
////
//
//import Foundation
//import Combine
//import CoreLocation
//
//
//
//
//    mutating func validates(
//        lastDistance: CLProximity,
//        loggedIn: Bool,
//        currentBeacon: CurrentBeacon,
//        detector: BeaconDetector,
//        session: SessionStore
//        //currentBeaconDistances: Array<CLProximity>
//    ) {
//
//        let lastBeaconUID  = detector.lastBeacon.uuid
//        let lastBeaconMaj  = detector.lastBeacon.major
//        let lastBeaconMin  = detector.lastBeacon.minor
//
//        //Array of 5 elements. Remove after 5
//        //This array solves the issue of "wild reads"
//        if(currentBeaconDistances.count >= 5) {
//            currentBeaconDistances.removeFirst()
//        }
//
//        currentBeaconDistances.append(lastDistance)
//
//        let countImmediate = currentBeaconDistances.reduce(0) { $1 == .immediate ? $0 + 1 : $0 }
//        let countNear = currentBeaconDistances.reduce(0) { $1 == .near ? $0 + 1 : $0 }
//        let countFar = currentBeaconDistances.reduce(0) { $1 == .far ? $0 + 1 : $0 }
//        let countUnknown = currentBeaconDistances.reduce(0) { $1 == .unknown ? $0 + 1 : $0 }
//
//        print("Immediate: \(countImmediate)")
//        print("Near: \(countNear)")
//        print("Far: \(countFar)")
//        print("unknown: \(countUnknown)")
//
//        //If not the same exact beacon and distance is near
//        if(countImmediate > 3 || countNear > 3) {
//                //Beacon loads on phone no matter what
//                currentBeacon.loadBeacon(major: lastBeaconMaj, minor: lastBeaconMin, uid: lastBeaconUID)
//
//                //Begin sessions only works if current beacon isnt occupied by other user (server/helpers.js)
//
//                print("logged in: \(loggedIn)")
//
//            Api.init(session: session,  currentBeacon: currentBeacon).beginSession(beacon: "hello")
//
//                if(session.isLoggedIn == false) {
//                    Api(session: session, currentBeacon: currentBeacon).endSession()
//                }
//        }
//
//        //If distance is far
//        else if(countUnknown > 3 || countFar > 3) {
//            if(lastDistance.rawValue > 2) {
//                //Unload the beacon
//                currentBeacon.unloadBeacon()
//                //End the websocket session
//                Api.init(session: session,  currentBeacon: currentBeacon).endSession()
//            }
//        }
//
//    }
//
