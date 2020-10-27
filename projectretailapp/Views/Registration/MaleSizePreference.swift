//
//  MaleSizePreference.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/16/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI


struct MaleSizePreference: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var sizingPreferences: SizingPreferences
    @EnvironmentObject var session: SessionStore
    
    var sessionStore: SessionStore

    @State var sex = "male"
    
    @State var length: Int = 0
    @State var waist: Int = 0
    @State var shirtSize: String = ""
    
    init(sessionStore: SessionStore) {
        self.sessionStore = sessionStore
        self._length = State(initialValue: sessionStore.userSession?.maleLengthSize ?? 0)
        self._waist = State(initialValue: sessionStore.userSession?.maleLengthSize ?? 0)
        self._shirtSize = State(initialValue: sessionStore.userSession?.maleShirtSize ?? "")
    }
    
    @State var updatedShirtSize = false
    
    var body: some View {
        
        ZStack {
            
            Color(#colorLiteral(red: 0.8017465693, green: 0.9201128859, blue: 1, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 10) {
                Spacer()
                
                Image("maleSilhouette")
                    .resizable()
                    .frame(width: 40, height: 100, alignment: .center)
                    .padding(.top, 30)
                
                GeometryReader { geometry in
                    HStack(spacing: 0) {
                        VStack {
                            Picker(selection: self.$length, label: Text("Numbers")) {
                                ForEach(MENS_LENGTH_SIZES) { length in
                                    Text("\(length)")
                                        .font(.headline)
                                }
                            }
                            .frame(maxWidth: geometry.size.width / 2)
                            .clipped()
                            
                            Text("Length")
                                .font(.headline)
                        }

                        VStack {
                            Picker(selection: self.$waist, label: Text("Numbers")) {
                                ForEach(MENS_WAIST_SIZES) { waist in
                                    Text("\(waist)")
                                        .font(.headline)
                                }
                            }
                            .frame(maxWidth: geometry.size.width / 2)
                            .clipped()

                            Text("Waist")
                                .font(.headline)
                        }
                    }
                }
                
                
                ShirtSizePreferences(inheretedSize: session.userSession?.maleShirtSize ?? "M") { selected in
                    self.updatedShirtSize = true //So does not set back to M
                    self.shirtSize = selected
                    
                }
                
                
                Text("Length: \(length) , Waist: \(self.waist), Shirt: \(shirtSize)")
                
                
                Text("Back")
                    .onTapGesture {
                        viewRouter.currentPage = "sexPreference"
                    }
                if(sizingPreferences.hasSelectedFemale == true) {
                    Text("Next")
                        .onTapGesture {
                            
                            //Store male sizing to user object
                            //Next time it will attach will be on login
                            if(shirtSize != "") {
                                session.userSession?.maleShirtSize = self.shirtSize
                            }
                            
                            if(length != 0) {
                                session.userSession?.maleWaistSize = self.waist
                            }
                            
                            if(waist != 0) {
                                session.userSession?.maleLengthSize = self.length
                            }
                            
                            viewRouter.currentPage = "female"
                        }
                } else {
                    Text("Finish")
                        .onTapGesture {
                            viewRouter.currentPage = "home"
                            
                            //Change Session values if they have been changed
                            if(shirtSize != "") {
                                session.userSession?.maleShirtSize = self.shirtSize
                            }
                            
                            if(length != 0) {
                                session.userSession?.maleWaistSize = self.waist
                            }
                            
                            if(waist != 0) {
                                session.userSession?.maleLengthSize = self.length
                            }
    
  
                            StorageService.updateMaleOnlySizingPreferences(
                                userId: session.userSession?.uid ?? "",
                                maleShirtSize: session.userSession?.maleShirtSize ?? "M",
                                maleWaistSize: session.userSession?.maleWaistSize ?? 26,
                                maleLengthSize: session.userSession?.maleLengthSize ?? 26)
   
                            session.hasEnteredSizes = true
                        }
                }
            }
        }
    }
    
}





