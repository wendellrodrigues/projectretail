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

            VStack(spacing: 25.0) {
                
                Text("Settings")
                    .font(Font.custom("DMSans-Bold", size: 20))
                    .foregroundColor(Color.black)
                    .padding(.top, 20)
                
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
                    .padding(.bottom, 30)
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
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(Font.custom("DMSans-Bold", size: 15))
                .imageScale(.large)
                .frame(width: 32, height: 32)
                .foregroundColor(Color("Primary"))
            Text(title)
                .font(Font.custom("DMSans-Bold", size: 15))
                .frame(width: 200, alignment: .leading)
                .foregroundColor(Color.gray)
        }
    }
}


