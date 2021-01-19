//
//  CurrentBeacon.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/3/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import Combine

class CurrentBeacon: ObservableObject {
    
    @Published var beacon = Beacon(UUID: "", major: 0, minor: 0, name: "", sizes: [])
    @Published var isLoaded: Bool = false
    
    func loadBeacon(major: Int, minor: Int, uid: String) {
    
        //Check to make sure not the same major/minor. Return if it is
        if(self.beacon.major == major ||
            self.beacon.minor == minor) {
            return
        }
        
        self.isLoaded = true
        
        //Find beacon from Firebase
        Ref.FIRESTORE_COLLECTION_BEACONS
            //Match fields to beacon
            .whereField("UUID", isEqualTo: uid)
            .whereField("major", isEqualTo: "3838")
            .whereField("minor", isEqualTo: "4949")
            .getDocuments() { (snapshot, err) in
                if let err = err {
                    print (err)
                } else {
                    for doc in snapshot!.documents {
                        //Get data
                        let data = doc.data()
                        let major = data["major"] as? String ?? ""
                        let minor = data["minor"] as? String ?? ""
                        let name = data["name"] as? String ?? ""
                        let UUID = data["UUID"] as? String ?? ""
                        let sizes = data["sizes"] as? [Any] ?? []
                        
                        let intMajor = Int(major) ?? 0
                        let intMinor = Int(minor) ?? 0
                        
                       //Set state
                        let stateBeacon = Beacon(UUID: UUID, major: intMajor, minor: intMinor, name: name, sizes: sizes)
                        self.beacon = stateBeacon
                    }
                }
            }
    }
    
    
    func unloadBeacon() {
        print("unloading beacon")
        self.isLoaded = false
        let stateBeacon = Beacon(UUID: "", major: 0, minor: 0, name: "", sizes: [])
        self.beacon = stateBeacon
    }
}


