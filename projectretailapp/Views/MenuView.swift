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
            VStack(spacing: 16.0) {
                
                MenuRow(title: "Sizing Preferences" , icon: "gear")
                    .onTapGesture {
                        viewRouter.currentPage = "sexPreference"
                    }
                MenuRow(title: "Sign Out" , icon: "person.crop.circle")
                    .onTapGesture {
//                        UserDefaults.standard.set(false, forKey: "isLogged")
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
            .frame(maxWidth: .infinity)
            .frame(height: 150)
            //Gradient with color literal
            .background(BlurView(style: .systemUltraThinMaterial))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.25), radius: 20, x: 0, y: 20)
            .padding(.horizontal, 30)
//            .overlay(
//                Image("Avatar")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 60, height: 60)
//                    .clipShape(Circle())
//                .offset(y: -150)
//            )
        }
        .padding(.bottom, 30)

        
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
                .foregroundColor(Color(#colorLiteral(red: 0.662745098, green: 0.7333333333, blue: 0.831372549, alpha: 1)))
            Text(title)
                .font(.system(size: 15, weight: .bold, design: .default))
                .frame(width: 200, alignment: .leading)
        }
    }
}


