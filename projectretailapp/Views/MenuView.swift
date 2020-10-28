//
//  MenuView.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/26/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var viewRouter: ViewRouter
    
    @ObservedObject var detector = BeaconDetector()
    @ObservedObject var currentBeacon = CurrentBeacon()
    
    @Binding var showProfile: Bool
    
    @State var viewState = CGSize.zero
    let screen = UIScreen.main.bounds
    
    func logout() {
        //Set detector's last distance to unknown
        detector.lastDistance = .unknown
        //Change viewRouter
        viewRouter.currentPage = "signin"
        //Log out of phone session
        session.logout()
    }
    
    var body: some View {
        VStack {

            Spacer()
            
//            Text("Settings")
//                .font(.headline)
//                .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
//                //.foregroundColor(Color.black)
//                .fontWeight(.bold)
//                .padding(.bottom, 30)
            
            
            VStack(spacing: 25.0) {
                
                MenuRow(title: "Sizing Preferences" , icon: "gear")
                    .onTapGesture {
                        viewRouter.currentPage = "sexPreference"
                        haptic(type: .success)
                    }
                MenuRow(title: "Sign Out" , icon: "person.crop.circle")
                    .onTapGesture {
                        haptic(type: .success)
                        //Unload the beacon
                        currentBeacon.unloadBeacon()
                        //Logout user on phone
                        self.logout()
                        //End websocket connection
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            Api(session: self.session, currentBeacon: self.currentBeacon).endSession()
                        }   
                }
            }

            .modifier(MenuModifier())
        }
        .padding(.bottom, 70)

        
    }
}

struct MenuRow: View {
    
    var title : String
    var icon : String
    
    
    var body: some View {
        HStack(spacing: 30) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .light, design: .default))
                .imageScale(.large)
                .frame(width: 32, height: 32)
                //.foregroundColor(Color(#colorLiteral(red: 0.662745098, green: 0.7333333333, blue: 0.831372549, alpha: 1)))
                .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 0.5449611997)))
            Text(title)
                .font(.system(size: 15, weight: .bold, design: .default))
                .frame(width: 200, alignment: .leading)
                .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
        }
    }
}


