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
import FirebaseStorage

struct Home: View {
    
    @ObservedObject var detector = BeaconDetector()
    @ObservedObject var currentBeacon = CurrentBeacon()
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var sizingPreferences: SizingPreferences
    
    @EnvironmentObject var session: SessionStore
    
    @State var currentBeaconDistances: Array<CLProximity> = []

    
    //Use this for simple beacon obj (if needed)
    //@State var currentBeaconObj = Beacon(UUID: "", major: "", minor: "", name: "", sizes: [])
    
    func logout() {
        //Set detector's last distance to unknown
        detector.lastDistance = .unknown
        //Change viewRouter
        viewRouter.currentPage = "signin"
        //Log out of phone session
        session.logout()
    }
    
    func validate(lastDistance: CLProximity, loggedIn: Bool) {

        let lastBeaconUID  = self.detector.lastBeacon.uuid
        let lastBeaconMaj  = self.detector.lastBeacon.major
        let lastBeaconMin  = self.detector.lastBeacon.minor

        //Array of 5 elements. Remove after 5
        //This array solves the issue of "wild reads"
        if(currentBeaconDistances.count >= 5) {
            currentBeaconDistances.removeFirst()
        }

        currentBeaconDistances.append(lastDistance)

        let countImmediate = currentBeaconDistances.reduce(0) { $1 == .immediate ? $0 + 1 : $0 }
        let countNear = currentBeaconDistances.reduce(0) { $1 == .near ? $0 + 1 : $0 }
        let countFar = currentBeaconDistances.reduce(0) { $1 == .far ? $0 + 1 : $0 }
        let countUnknown = currentBeaconDistances.reduce(0) { $1 == .unknown ? $0 + 1 : $0 }
//
//        print("Immediate: \(countImmediate)")
//        print("Near: \(countNear)")
//        print("Far: \(countFar)")
//        print("unknown: \(countUnknown)")

        //If not the same exact beacon and distance is near
        if(countImmediate > 1 || countNear > 1) {
                //Beacon loads on phone no matter what
                currentBeacon.loadBeacon(major: lastBeaconMaj, minor: lastBeaconMin, uid: lastBeaconUID)

                //Begin sessions only works if current beacon isnt occupied by other user (server/helpers.js)

                Api.init(session: self.session,  currentBeacon: self.currentBeacon).beginSession(beacon: "hello")

                if(session.isLoggedIn == false) {
                    Api(session: self.session, currentBeacon: self.currentBeacon).endSession()
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
            
            Text("Male Shirt Size \(session.userSession?.maleShirtSize ?? "notiong")")
            Text("Male Waist Size \(session.userSession?.maleWaistSize ?? 0)")
            Text("Male Length Size \(session.userSession?.maleLengthSize ?? 0)")
            Text("Female Shirt Size \(session.userSession?.femaleShirtSize ?? "nothing")")
            Text("Female Pant Size \(session.userSession?.femalePantsSize ?? "nothing")")
            
            
            
            //Extra Argument because ONLY 10 direct subViews are allowed
            //Add Group { SomeView SomeView SomeView } to get around this
            
            Button(action: {
                //Unload the beacon
                currentBeacon.unloadBeacon()
                //Logout user on phone
                self.logout()
                //End websocket connection
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    Api(session: self.session, currentBeacon: self.currentBeacon).endSession()
                }

            }) {
               Text("Logout")
            }.padding(.bottom)
        }
        //Handles Changes to Detector
        .onReceive(detector.$lastDistance) {_ in
            validate(lastDistance: detector.lastDistance, loggedIn: session.isLoggedIn)
        }

        
    }

}



