//
//  Broadcast.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/8/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


struct SessionModel: Codable {
    var userId: String
    var beaconId: String
    var beaconMajor: String
    var beaconMinor: String
}


struct Api {
    
    @ObservedObject var session: SessionStore
    @ObservedObject var currentBeacon =  CurrentBeacon()
    
    @ObservedObject var detector = BeaconDetector()
    
    
    //Adds user to array of nearby users
    func addUserToSystemProximity(beaconUUID: String, beaconMajor: Int, beaconMinor: Int) {
        
        
        //First check to ssee if the currentBeacon is already in use
        if(currentBeacon.beacon.UUID != "") { return }

        //URL Specifics
        guard let url = URL(string: "http:\(REQUEST_URL):3000/routes/addUser") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/JSON", forHTTPHeaderField: "Accept")
        request.setValue("application/JSON", forHTTPHeaderField: "Content-Type")
        
        guard let userId = session.userSession?.uid else { return }
        
        let beaconMajString = String(beaconMajor)
        let beaconMinString = String(beaconMinor)
 
        //Structure data
        let infoToSend = SessionModel(
                            userId: userId,
                            beaconId: beaconUUID,
                            beaconMajor: beaconMajString,
                            beaconMinor: beaconMinString
                        )

        
        //Encode JSON
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let jsonData = try! encoder.encode(infoToSend)
      
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            //print(data!)
        }
        .resume()
        
        print("/addUser request sent")
    }
    
    
    //Removes user from a corresponding iPads' array of nearby users
    func removeUserFromSystemProximity(beaconUUID: String, beaconMajor: Int, beaconMinor: Int) {
        
        print("removing user")
        

        guard let url = URL(string: "http://\(REQUEST_URL):3000/routes/removeUser") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/JSON", forHTTPHeaderField: "Accept")
        request.setValue("application/JSON", forHTTPHeaderField: "Content-Type")
        
        
        //If no session userSession, use the lastUser session
        let userId = session.userSession?.uid ?? session.lastUserId
        
        let beaconMajString = String(beaconMajor)
        let beaconMinString = String(beaconMinor)
        
        let infoToSend = SessionModel(
            userId: userId,
            beaconId: beaconUUID,
            beaconMajor: beaconMajString,
            beaconMinor: beaconMinString
        )
        
        //Encode JSON
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let jsonData = try! encoder.encode(infoToSend)
      
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            //print(data!)
        }
        .resume()
        
        print("/removeUser request sent")
    }
    
    
    
    
    
    
    
}
