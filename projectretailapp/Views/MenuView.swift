//
//  MenuView.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/26/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI
import Combine

struct MenuView: View {
    
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var viewRouter: ViewRouter
    
    @ObservedObject var detector = BeaconDetector()
    @ObservedObject var currentBeacon = CurrentBeacon()
    
    @Binding var showProfile: Bool
    
    @State var viewState = CGSize.zero
    
    var lastBeacon: BeaconRef
    
    let screen = UIScreen.main.bounds
    
    func logout() {
        //Store local data of last user logged in
        session.lastUserId = session.userSession?.uid ?? ""
        //Set detector's last distance to unknown
        detector.lastDistance = .unknown
        //Change viewRouter
        viewRouter.currentPage = "signin"
        //Unload beacon
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            currentBeacon.unloadBeacon()
        }
        //Log out of phone session
        session.logout()
    }
    
    func changeBeacon() {
        
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
                        
                        //Remove user from array of nearby shelf users
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            Api.init(session: self.session,  currentBeacon: self.currentBeacon).removeUserFromSystemProximity(
                                beaconUUID: self.lastBeacon.uuid,
                                beaconMajor: self.lastBeacon.major,
                                beaconMinor: self.lastBeacon.minor
                            )
                        }

                        //Logout user on phone
                        self.logout()
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


