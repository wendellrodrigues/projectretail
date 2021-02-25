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
    @State var lastBeacon = BeaconRef(uuid: "", major: 0, minor: 0)
   
    @State var productImage: UIImage = UIImage()
    @State var productTapped: Bool = false
    
    
    //Screen
    @State var viewState = CGSize.zero
    @State var showProfile = false
    let screen = UIScreen.main.bounds
    
    func validate(lastDistance: CLProximity, loggedIn: Bool) {

        //Beacon information of found beacon
        let lastBeaconUUID  = self.detector.lastBeacon.uuid
        let lastBeaconMaj  = self.detector.lastBeacon.major
        let lastBeaconMin  = self.detector.lastBeacon.minor
        
        //Fill info of lastBeacon (for passing to logout function)
        lastBeacon = BeaconRef(uuid: lastBeaconUUID, major: lastBeaconMaj, minor: lastBeaconMin)
        
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
        
            if(countImmediate == 2 || countNear == 2) { //Beacon loads on phone no matter what
                //Find the current beacon as specified by the UID (find on firebase and store the corresponding data)
                currentBeacon.loadBeacon(
                    major: lastBeaconMaj,
                    minor: lastBeaconMin,
                    uid: lastBeaconUUID
                )
                
                //Request the server
                Api.init(session: self.session,  currentBeacon: self.currentBeacon)
                    .addUserToSystemProximity(
                        beaconUUID: lastBeaconUUID,
                        beaconMajor: lastBeaconMaj,
                        beaconMinor: lastBeaconMin
                    )
            }
        }
       
       else if(countUnknown > 7 || countFar > 7
               && countUnknown < 9 && countFar < 9) //Sweet spot so it doesnt keep sending end requests
       {
            //If distance is far
            if(countFar == 8 || countUnknown == 8) { //Sweet spot so it doesnt keep sending end requests
                if(lastDistance.rawValue > 2) {
                    //End the websocket session
                    Api.init(session: self.session,  currentBeacon: self.currentBeacon).removeUserFromSystemProximity(
                        beaconUUID: lastBeaconUUID,
                        beaconMajor: lastBeaconMaj,
                        beaconMinor: lastBeaconMin
                    )
                    //Unload the beacon
                    currentBeacon.unloadBeacon()
                }
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
                    ZStack {
                        if(!currentBeacon.isLoaded) {
                            VStack {
                                SearchingView(session: session)
                            }
                            Spacer()
                        }
                        else {
                            VStack {
                                Text("Nearby Shelf")
                                    .font(Font.custom("DMSans-Bold", size: 30))
                                    .padding(.top, 30)
                                    .padding(.bottom, 10)
                                    .opacity(productTapped ? 0 : 1)
                                    .animation(.easeInOut)
                                ProductView(currentBeacon: currentBeacon, productImage: productImage, tapped: $productTapped)
                                Spacer()
                            }
                        }
                        VStack {
                            Text("Find one of our tablets and tap begin")
                                .font(Font.custom("DMSans-Bold", size: 17))
                                .foregroundColor(.gray)
                                .padding(.bottom, 20)
                            Image("iPad")
                                .resizable()
                                .frame(width: 250, height: 170, alignment: .center)
                        }
                        .offset(x: 0, y: 140)
                        .opacity(productTapped ? 0 : 1)
                        .animation(.easeInOut)
                }
                    
                }
                .blur(radius: showProfile ? 4 : 0)
            }
            .modifier(HomeModifier(showProfile: $showProfile, viewState: $viewState))

            //Handles Changes to Detector
            .onReceive(detector.$lastDistance) {_ in
                validate(lastDistance: detector.lastDistance, loggedIn: session.isLoggedIn)
            }
            
            MenuView(showProfile : $showProfile, lastBeacon: lastBeacon)
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
        .onTapGesture {
            productTapped = false
        }
    }
}

struct ProductView: View {
    
    @State var currentBeacon: CurrentBeacon
    @State var productImage: UIImage
    @Binding var tapped: Bool
    
    var body: some View {
        
        VStack {
            if(tapped == false) {
                ProductViewSummary(currentBeacon: currentBeacon, productImage: $productImage)
                    .onTapGesture {
                        tapped.toggle()
                    }
            } else {
                ProductViewFull(currentBeacon: currentBeacon, productImage: productImage)
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 0)
        .frame(width:  UIScreen.main.bounds.size.width - 40)
        .animation(.spring())
        //.offset(x: 0, y: tapped ? -40 : 0)
        
        Spacer()
    }
}

struct ProductViewSummary: View {
    
    @State var currentBeacon: CurrentBeacon
    @Binding var productImage: UIImage
    
    var body: some View {
            HStack {
                Image(uiImage: (productImage))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                    .padding(.leading, 20)
                    .padding(.trailing, 10)
                    .padding(.vertical, 15)
                VStack(alignment: .leading) {
                    Text(currentBeacon.beacon.name)
                        .font(Font.custom("DMSans-Bold", size: 20))
                        .foregroundColor(Color.black)
                    Text(currentBeacon.beacon.color)
                        .font(Font.custom("DMSans-Bold", size: 13))
                        .foregroundColor(Color.gray)
                }

                Spacer()
                Text("Learn More")
                    .font(Font.custom("DMSans-Bold", size: 12))
                    .foregroundColor(Color.gray)
                    .padding(.trailing, 30)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { //0.5 second delay to account for latency
                    //Load product image
                    loadFirebaseImage(url: "gs://projectretail-4dd60.appspot.com/\(currentBeacon.beacon.image)") { image in
                        self.productImage = image
                    }
                }
            }
        }
}

struct ProductViewFull: View {
    
    @State var currentBeacon: CurrentBeacon
    @State var productImage: UIImage
    
    var body: some View {
        VStack {
            
            VStack() {
                Text(currentBeacon.beacon.name)
                    .font(Font.custom("DMSans-Bold", size: 30))
                    .foregroundColor(Color.black)
                Text(currentBeacon.beacon.color)
                    .font(Font.custom("DMSans-Bold", size: 17))
                    .foregroundColor(Color.gray)
            }
            .padding(.top, 20)
            Image(uiImage: (productImage))
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .padding(.leading, 20)
                .padding(.trailing, 10)
                .padding(.vertical, 15)
                .frame(width: UIScreen.main.bounds.size.width - 40, height: 150)
                .padding(.bottom, 20)
            Text(currentBeacon.beacon.description)
                .font(Font.custom("DMSans-Medium", size: 12))
                .foregroundColor(Color.gray)
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
            Text("$\(String(currentBeacon.beacon.price))")
                .font(Font.custom("DMSans-Medium", size: 24))
                .foregroundColor(Color.black.opacity(0.6))
                .padding(.bottom, 10)
            
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: UIScreen.main.bounds.width - 80, height: 1)
                .padding(.bottom, 20)
            
            VStack {
                HStack{
                    Text("Recently Viewed Items")
                        .font(Font.custom("DMSans-Medium", size: 12))
                        .foregroundColor(Color.gray)
                        .padding(.leading, 30)
                    Spacer()
                }
                RecentlyViewedItems()
            }
            .padding(.bottom, 20)
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { //0.5 second delay to account for latency
                //Load product image
                loadFirebaseImage(url: "gs://projectretail-4dd60.appspot.com/\(currentBeacon.beacon.image)") { image in
                    self.productImage = image
                }
            }
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
        Spacer()
    }
}



