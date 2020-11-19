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
    
    let screen = UIScreen.main.bounds.size
    
    //For testing purposes. Remove later
    func logout() {
        viewRouter.currentPage = "signin" //Redirect to signIn
        session.logout() //Log out of phone session
    }
    
 
    //Handles action on what page to go to when the user hits continue button after selecting sex
    func maleOrFemaleContinue() {
        if(sizingPreferences.hasSelectedMale) {
            viewRouter.currentPage = "male"
        } else if(sizingPreferences.hasSelectedFemale) {
            viewRouter.currentPage = "female"
        }
    }
    
    func cancel() {
        viewRouter.currentPage = "home"
    }
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(TXT_PRODUCT_HELP)
                    .font(.custom("DMSans-Bold", size: 25))
                    .foregroundColor(Color("Primary"))
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .padding(20)
                    .padding(.top, 80)
                    .padding(.bottom, 5)

                VStack {
                    HStack(alignment: .center) {
                        SilhouetteButton(sex: "male")
                        Spacer()
                        SilhouetteButton(sex: "female")
                    }
                    .padding([.leading, .trailing], 20)
                    .padding(.bottom, 50)
                    .padding(.top, 30)
                    
                    Text(TXT_SEX_HELP)
                        .font(.custom("DMSans-Bold", size: 18))
                        .padding(.bottom, 20)
                        .padding(20)
                        .padding(.top, session.hasEnteredSizes ? -30 : 0)
                }
                .padding()
                .frame(width: screen.width - 20)
                .background(Color("TextField_Background"))
                .cornerRadius(20)
                .padding(.bottom, 20)
                
                LargeButton(label: TEXT_CONTINUE, action: maleOrFemaleContinue)
                
                if(session.hasEnteredSizes) {
                    Text("Cancel")
                        .font(.custom("DMSans-Bold", size: 14.5))
                        .foregroundColor(Color.black.opacity(0.7))
                        .fontWeight(.bold)
                        .padding(.top, -5)
                        .padding()
                        .onTapGesture {
                            cancel()
                            haptic(type: .error)
                        }
                }

            }
        }
    }
}




