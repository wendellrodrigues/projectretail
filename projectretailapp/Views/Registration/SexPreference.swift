//
//  SexPreference.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/14/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SexPreference: View {
    
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var sizingPreferences: SizingPreferences
    
    @EnvironmentObject var viewRouter: ViewRouter

    @State var selectedMale: Bool = false
    @State var selectedFemale: Bool = false

    @State var tap = false
    @State var press = false
    
    //For testing purposes. Remove later
    func logout() {
        //Log out of phone session
        viewRouter.currentPage = "signin"
        session.logout()
    }
    
    func sizingAccepted() {
        //session.userSession?.hasEnteredSizingPreferences = true
        let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(userId: session.userSession?.uid ?? "")
        firestoreUserId.updateData([
            "hasEnteredSizingPreferences": true
        ])
    }
    
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8017465693, green: 0.9201128859, blue: 1, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack(alignment: .center) {
                    
                    Image("maleSilhouette")
                        .resizable()
                        .frame(width: 80, height: 200, alignment: .center)
                        .gesture(
                            LongPressGesture(minimumDuration: 0.1, maximumDistance: 10).onChanged { value in
                                sizingPreferences.hasSelectedMale.toggle()
                                haptic(type: .success)
                                print("male : \(sizingPreferences.hasSelectedMale)")
                                print("female : \(sizingPreferences.hasSelectedFemale)")
                            }
                        )
                        .opacity(sizingPreferences.hasSelectedMale ? 1 : 0.2)
                        .animation(.easeInOut)
                    
                    Spacer()
                    
                    Image("femaleSilhouette")
                        .resizable()
                        .frame(width: 80, height: 200, alignment: .center)
                        .gesture(
                            LongPressGesture(minimumDuration: 0.1, maximumDistance: 10).onChanged { value in
                                sizingPreferences.hasSelectedFemale.toggle()
                                haptic(type: .success)
                            }
                        )
                        .opacity(sizingPreferences.hasSelectedFemale ? 1 : 0.2)
                        .animation(.easeInOut)
                        
                }
                .padding([.leading, .trailing], 60)
                .padding(.bottom, 100)
                
                //INCLUDE LOGIC ON WHAT PAGE TO GO TO NEXT

                HStack {
                    Spacer()
                    ZStack {
                        Text(TEXT_CONTINUE)
                            .modifier(SignInButtonModifier(tap: self.tap, press: self.press))
                            .gesture(
                                LongPressGesture(minimumDuration: 0.1, maximumDistance: 10).onChanged { value in
                                    self.tap = true
                                    //Put action here
//                                  sizingAccepted()
//                                  session.hasEnteredSizes = true
                                    haptic(type: .success)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        self.tap = false
                                    }
                                    if(sizingPreferences.hasSelectedMale) {
                                        viewRouter.currentPage = "male"
                                    } else if(sizingPreferences.hasSelectedFemale) {
                                        viewRouter.currentPage = "female"
                                    }
                                }
                                .onEnded { value in
                                    self.press.toggle()
                                }
                            )
                            .animation(.easeInOut)
                        }
                    
                    Spacer()
                }
 
                
                
                
//                Button(action: sizingAccepted, label: {
//                    Text("Logout")
//                })
                Button(action: logout, label: {
                    Text("Logout")
                })
            
            }
        }
    }
}




