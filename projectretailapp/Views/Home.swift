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

    
    var body: some View {
          
        VStack {
            Spacer()
            Text("Welcome, \(session.userSession?.firstName ?? "User")")
                .font(.largeTitle)
                .fontWeight(.bold)
            .padding(.bottom)
            Spacer()
            
            Button(action: {
                Api(session: self.session).endSession()
                self.logout()
               
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
                Api.init(session: self.session).beginSession()
            } else if(self.detector.lastDistance == .far) {
               print("Far")
                Api.init(session: self.session).endSession()
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

