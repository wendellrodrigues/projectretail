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
            
            //Write function to detect last state changes, timers, etc.
            
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
        
    }
    
}
    


//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}

