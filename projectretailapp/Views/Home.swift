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

class BeaconDetector: NSObject, ObservableObject, CLLocationManagerDelegate {

   // var didChange = PassthroughSubject<Void, Never>()
    var objectWillChange = ObservableObjectPublisher()
    var locationManager: CLLocationManager?

    var beaconUUID: UUID = UUID(uuidString: "7777772E-6B6B-6D63-6E2E-636F6D000001")!
    var beaconMajor: CLBeaconMajorValue = 3838
    var beaconMinor: CLBeaconMinorValue = 4949

    //@EnvironmentObject var userSession: SessionStore
    @Published var lastDistance = CLProximity.unknown

    override init() {

        super.init()

        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()

    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        //Change to always
        if status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // We are good to go!
                    startScanning()
                }
            }
        }
    }

    func startScanning() {
        let constraint = CLBeaconIdentityConstraint(uuid: beaconUUID, major: beaconMajor, minor: beaconMinor)
        let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: constraint, identifier: "BlueCharm_893")
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(satisfying: constraint)
    }

    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        if let beacon = beacons.first {
            update(distance: beacon.proximity)
        } else {
            update(distance: .unknown)
        }
    }

    func update(distance: CLProximity) {
        if((distance == .near || distance == .immediate) && (lastDistance == .far) || lastDistance == .unknown) {
            //Api(session: self.userSession).connectUser()
           print("It is now near")

        }

        lastDistance = distance
        //didChange.send(())
        self.objectWillChange.send()
    }
}

struct Home: View {
    
    @ObservedObject var detector = BeaconDetector()
    
    @EnvironmentObject var session: SessionStore
    
    
    func logout() {
        session.logout()
    }
    
    func connectUser() {
        Api(session: self.session).connectUser()
    }
    
    
    var body: some View {
          
        VStack {
            Spacer()
            Text("Welcome, \(session.userSession!.firstName)")
                .font(.largeTitle)
                .fontWeight(.bold)
            .padding(.bottom)
            
            
            Spacer()
            
            Button(action: {
                self.logout()
                Api(session: self.session).disconnectUser()
            }) {
               Text("Logout")
            }.padding(.bottom)
        }
        //Handles Changes to Detector
        .onReceive(detector.$lastDistance) {_ in
            if(self.detector.lastDistance == .immediate) {
                   print("Close")
            } else if(self.detector.lastDistance == .near) {
               print("Kinda close")
                Api.init(session: self.session).connectUser()
            } else if(self.detector.lastDistance == .far) {
               print("Far")
                Api.init(session: self.session).disconnectUser()
           } else {
                print("Unknown")
           }
        }
        
//        .onAppear(perform: {
//            if(self.detector.lastDistance == .immediate) {
//                print("Close")
//            } else if(self.detector.lastDistance == .near) {
//                print("kinda close")
//            } else {
//                print("Far")
//            }
//        })
    }
    
}
    


//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}

