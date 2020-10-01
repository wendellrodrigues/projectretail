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

struct Home: View {
    
    @ObservedObject var detector = BeaconDetector()
    @EnvironmentObject var session: SessionStore
    
    @State var currentBeacon = Beacon(uuid: "", major: 0, minor: 0)
    
    
    func logout() {
        session.logout()
    }
    
    func loadBeacon(major: Int, minor: Int) {
        Ref.FIRESTORE_COLLECTION_GROUP_STORES
            .whereField("major", isEqualTo: major)
//            .whereField("minor", isEqualTo: minor)
            .getDocuments { (snapshot, err) in
                if let err = err {
                    print(err)
                } else {
                    print("found")
                    print(snapshot)
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
            
            Text(String(currentBeacon.major))
            Text(String(currentBeacon.minor))
            
            Button(action: {
                Api(session: self.session).endSession()
                self.logout()
               
            }) {
               Text("Logout")
            }.padding(.bottom)
        }
        //Handles Changes to Detector
        .onReceive(detector.$lastDistance) {_ in
            
            let stateBeaconMaj = self.currentBeacon.major
            let stateBeaconMin = self.currentBeacon.minor
        
            let lastBeaconUID  = self.detector.lastBeacon.uuid
            let lastBeaconMaj  = self.detector.lastBeacon.major
            let lastBeaconMin  = self.detector.lastBeacon.minor

            
            //Not unknown
            if(lastBeaconMaj != 0 && lastBeaconMin != 0) {
                
                //If not the same exact beacon
                if(lastBeaconMaj != stateBeaconMaj && lastBeaconMin != stateBeaconMin) {
                    
                    print("Last Major: \(lastBeaconMaj)")
                    print("Last Minor: \(lastBeaconMin)")
                    
                    
                    loadBeacon(major: lastBeaconMaj, minor: lastBeaconMin)
                    currentBeacon.major = lastBeaconMaj
                    currentBeacon.minor = lastBeaconMin
                }
                
                
                
                
            }
        
            
            
            self.currentBeacon = self.detector.lastBeacon
            

            
            //Write function to detect last state changes, timers, etc.

//            if(self.detector.lastDistance == .immediate) {
//                   print("Close")
//            } else if(self.detector.lastDistance == .near) {
//               print("Kinda close")
//                Api.init(session: self.session).beginSession()
//            } else if(self.detector.lastDistance == .far) {
//               print("Far")
//                Api.init(session: self.session).endSession()
//           } else {
//                print("Unknown")
//           }
        }
        
    }
    
}
    


//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}

