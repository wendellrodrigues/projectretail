//
//  BeaconDetector.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/14/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation
import Firebase
import FirebaseStorage


class BeaconDetector: NSObject, ObservableObject, CLLocationManagerDelegate {

    var objectWillChange = ObservableObjectPublisher()
    var locationManager: CLLocationManager?

    //Create function to find these dynamically
    var beaconUUID: UUID = UUID(uuidString: "7777772E-6B6B-6D63-6E2E-636F6D000001")!
//    var beaconMajor: CLBeaconMajorValue = 3838
//    var beaconMinor: CLBeaconMinorValue = 4949

    @Published var lastDistance     = CLProximity.unknown
    @Published var lastBeacon       = Beacon(uuid: "7777772E-6B6B-6D63-6E2E-636F6D000001", major: 0, minor: 0)
  

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
                    startScanning()
                }
            }
        }
    }

    func startScanning() {
        let constraint = CLBeaconIdentityConstraint(uuid: self.beaconUUID)
        let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: constraint, identifier: "BlueCharm_893")
        self.locationManager?.startMonitoring(for: beaconRegion)
        self.locationManager?.startRangingBeacons(satisfying: constraint)
    }

    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        
        //If beacon is found
        if let beacon = beacons.first {
            let currentMaj = beacon.major.intValue
            let currentMin = beacon.minor.intValue
            updateDistance(distance: beacon.proximity)
            updateBeacon(currentMajor: currentMaj, currentMinor: currentMin)
        }
        
        //If beacon is not found
        else {
            updateDistance(distance: .unknown)
            updateBeacon(currentMajor: 0, currentMinor: 0)
        }
    }
    
    func updateDistance(distance: CLProximity) {
        lastDistance = distance
        self.objectWillChange.send()
    }

    func updateBeacon(currentMajor: Int, currentMinor: Int) {
        lastBeacon.major = currentMajor
        lastBeacon.minor = currentMinor
        self.objectWillChange.send()
    }
}

    

