//
//  Broadcast.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/8/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import SwiftUI


struct UserModel: Codable {
    var id: String
}


struct Api {
    
    @ObservedObject var session: SessionStore

    /**
        Connects the User to an iPad session in store
     */
    func beginSession() {
        print("Trying to connect to user")
        guard let url = URL(string: "http://10.0.0.249:5000/routes/getUser") else {
            print("No URL Found")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/JSON", forHTTPHeaderField: "Accept")
        request.setValue("application/JSON", forHTTPHeaderField: "Content-Type")
        
        guard let userId = session.userSession?.uid else {
            print("no user ID Found")
            return
            
        }
        
        let userToSend = UserModel(id: userId)
        print("ConnectingUser")
        //Encode JSON
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let jsonData = try! encoder.encode(userToSend)
        
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            //print(data!)
        }
        .resume()
    }
    
    /**
       Disconnects the User from an iPad session in store
    */
    func endSession() {
        guard let url = URL(string: "http://10.0.0.249:5000/routes/clearUser") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/JSON", forHTTPHeaderField: "Accept")
        request.setValue("application/JSON", forHTTPHeaderField: "Content-Type")
        
        
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            //print(data!)
        }
        .resume()
    }
}
