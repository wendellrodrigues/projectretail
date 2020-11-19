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
import FirebaseFirestoreSwift
import FirebaseStorage

struct Home: View {
    
    @ObservedObject var detector = BeaconDetector()
    @ObservedObject var currentBeacon = CurrentBeacon()
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var sizingPreferences: SizingPreferences
    
    @EnvironmentObject var session: SessionStore
    
    @State var currentBeaconDistances: Array<CLProximity> = []
    
    
    //Screen
    @State var viewState = CGSize.zero
    @State var showProfile = false
    
    let screen = UIScreen.main.bounds

    func logout() {
        //Set detector's last distance to unknown
        detector.lastDistance = .unknown
        //Change viewRouter
        viewRouter.currentPage = "signin"
        //Log out of phone session
        session.logout()
    }
    
    func validate(lastDistance: CLProximity, loggedIn: Bool) {

        let lastBeaconUID  = self.detector.lastBeacon.uuid
        let lastBeaconMaj  = self.detector.lastBeacon.major
        let lastBeaconMin  = self.detector.lastBeacon.minor

        //Array of 5 elements. Remove after 5
        //This array solves the issue of "wild reads"
        if(currentBeaconDistances.count >= 10) {
            currentBeaconDistances.removeFirst()
        }

        currentBeaconDistances.append(lastDistance)

        let countImmediate = currentBeaconDistances.reduce(0) { $1 == .immediate ? $0 + 1 : $0 }
        let countNear = currentBeaconDistances.reduce(0) { $1 == .near ? $0 + 1 : $0 }
        let countFar = currentBeaconDistances.reduce(0) { $1 == .far ? $0 + 1 : $0 }
        let countUnknown = currentBeaconDistances.reduce(0) { $1 == .unknown ? $0 + 1 : $0 }
//
//        print("Immediate: \(countImmediate)")
//        print("Near: \(countNear)")
//        print("Far: \(countFar)")
//        print("Unknown: \(countUnknown)")
//        print("")


        //If not the same exact beacon and distance is near
        
        //If too many far, do not do anything
       if(countImmediate > 1 || countNear > 1
          && countUnknown < 3 && countFar < 3)
       {
            //Beacon loads on phone no matter what
            currentBeacon.loadBeacon(major: lastBeaconMaj, minor: lastBeaconMin, uid: lastBeaconUID)
            
            //Begin sessions only works if current beacon isnt occupied by other user (server/helpers.js)
        
            //Find the current beacon as specified by the UID (find on firebase and store the corresponding data)
            
            Api.init(session: self.session,  currentBeacon: self.currentBeacon).beginSession(beacon: "hello")

            if(session.isLoggedIn == false) {
                Api(session: self.session, currentBeacon: self.currentBeacon).endSession()
            }
        }
       
        //If distance is far
        else if(countUnknown > 3 || countFar > 3
                && countUnknown < 7 && countFar < 7) //Sweet spot so it doesnt keep sending end requests
        {
            if(lastDistance.rawValue > 2) {
                //Unload the beacon
                currentBeacon.unloadBeacon()
                //End the websocket session
                Api.init(session: self.session,  currentBeacon: self.currentBeacon).endSession()
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                Group {
                    HStack {
                        Spacer()
                        MenuButton(showProfile: $showProfile)
                            .padding(.trailing, 50)
                            .padding(.top, 100)
                    }
                    Spacer()
                    
                    if(!currentBeacon.isLoaded) {
                        SearchingView(session: session)
                    } else {
                        Text(currentBeacon.beacon.name)
                        Spacer()
                    }
                    

    
                }
                .blur(radius: showProfile ? 4 : 0)
            }
            .modifier(HomeModifier(showProfile: $showProfile, viewState: $viewState))

            //Handles Changes to Detector
            .onReceive(detector.$lastDistance) {_ in
                validate(lastDistance: detector.lastDistance, loggedIn: session.isLoggedIn)
            }
            
            MenuView(showProfile : $showProfile)
                .background(Color.black.opacity(0.001))
                .offset(y: showProfile ? 0 : screen.height) //From screen value listed below
                .offset(y: viewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showProfile.toggle()
                    haptic(type: .error)
                }
                .gesture(DragGesture()
                .onChanged { value in
                    self.viewState = value.translation
                }
                .onEnded { value in
                    if self.viewState.height > 50 {
                        self.showProfile = false
                        haptic(type: .error)
                    }
                    self.viewState = .zero
                    }
                )
        }
    }
}


struct SearchingView: View {
    
    @State var session: SessionStore
    
    var body: some View {
        
        LottieViewLoop(fileName: "Radar")
            .frame(width: 700, height: 200, alignment: .center)
            .padding(.bottom, 30)

        Text("Welcome, \(session.userSession?.firstName ?? "Default")")
            .font(Font.custom("DMSans-Bold", size: 25))
            .fixedSize(horizontal: false, vertical: true)
            .padding(.bottom, 15)
        
        Text("Find one of our tablets and tap begin")
            .font(Font.custom("DMSans-Bold", size: 17))
            .foregroundColor(.gray)
            .padding(.bottom, 40)
        
        Image("iPad")
            .resizable()
            .frame(width: 250, height: 170, alignment: .center)
            .padding(.bottom, 100)
        
        Spacer()
    }
}



