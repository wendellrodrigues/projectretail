//
//  BeaconDetector.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/14/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

class BeaconDetector: NSObject, ObservableObject, CLLocationManagerDelegate {

    var objectWillChange = ObservableObjectPublisher()
    var locationManager: CLLocationManager?

    //Create function to find these dynamically
    var beaconUUID: UUID = UUID(uuidString: "7777772E-6B6B-6D63-6E2E-636F6D000001")!
    var beaconMajor: CLBeaconMajorValue = 3838
    var beaconMinor: CLBeaconMinorValue = 4949

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
        lastDistance = distance
        self.objectWillChange.send()
    }
}