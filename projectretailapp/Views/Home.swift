//
//  Home.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/3/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Combine
import CoreLocation
import SwiftUI
import FirebaseFirestoreSwift

struct Home: View {
    
    @ObservedObject var detector = BeaconDetector()
    @ObservedObject var currentBeacon = CurrentBeacon()
    
    @EnvironmentObject var session: SessionStore
    
    @State var currentBeaconDistances: Array<CLProximity> = []
    
    //Use this for simple beacon obj (if needed)
    //@State var currentBeaconObj = Beacon(UUID: "", major: "", minor: "", name: "", sizes: [])
    
    func logout() {
        //Set detector's last distance to unknown
        detector.lastDistance = .unknown
        //Log out of phone session
        session.logout()
    }
    
    func validate(lastDistance: CLProximity) {
        
        let lastBeaconUID  = self.detector.lastBeacon.uuid
        let lastBeaconMaj  = self.detector.lastBeacon.major
        let lastBeaconMin  = self.detector.lastBeacon.minor
        
        //Array of 5 elements. Remove after 5
        if(currentBeaconDistances.count >= 5) {
            currentBeaconDistances.removeFirst()
        }
        
        currentBeaconDistances.append(lastDistance)
        
        let countImmediate = currentBeaconDistances.reduce(0) { $1 == .immediate ? $0 + 1 : $0 }
        let countNear = currentBeaconDistances.reduce(0) { $1 == .near ? $0 + 1 : $0 }
        let countFar = currentBeaconDistances.reduce(0) { $1 == .far ? $0 + 1 : $0 }
        let countUnknown = currentBeaconDistances.reduce(0) { $1 == .unknown ? $0 + 1 : $0 }
        
//        print("Immediate: \(countImmediate)")
//        print("Near: \(countNear)")
//        print("Far: \(countFar)")
//        print("unknown: \(countUnknown)")
        
        //If not the same exact beacon and distance is near
        if(countImmediate > 3 || countNear > 3) {
            if(lastDistance.rawValue <= 2) {
                //Beacon loads on phone no matter what
                currentBeacon.loadBeacon(major: lastBeaconMaj, minor: lastBeaconMin, uid: lastBeaconUID)
                
                //Begin sessions only works if current beacon isnt occupied by other user (server/helpers.js)
                Api.init(session: self.session,  currentBeacon: self.currentBeacon).beginSession(beacon: "hello")
            }
        }

        //If distance is far
        else if(countUnknown > 3 || countFar > 3) {
            if(lastDistance.rawValue > 2) {
                //Unload the beacon
                currentBeacon.unloadBeacon()
                //End the websocket session
                Api.init(session: self.session,  currentBeacon: self.currentBeacon).endSession()
            }
        }
    }
    
    var body: some View {
          
        VStack {
            Spacer()
            Text("Welcome, \(session.userSession?.firstName ?? "User")")
                .font(.largeTitle)
                .fontWeight(.bold)
            .padding(.bottom)
            
            Spacer()
            
            Text(String(currentBeacon.beacon.UUID))
            
            Button(action: {
                //End websocket connection
                Api(session: self.session, currentBeacon: self.currentBeacon).endSession()
                //Unload the beacon
                currentBeacon.unloadBeacon()
                //Logout user on phone
                self.logout()
               
            }) {
               Text("Logout")
            }.padding(.bottom)
        }
        //Handles Changes to Detector
        .onReceive(detector.$lastDistance) {_ in
            validate(lastDistance: detector.lastDistance)
        }
        
    }
    
}
    



