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
    
    
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8017465693, green: 0.9201128859, blue: 1, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack(alignment: .center) {
                    SilhouetteButton(sex: "male")
                    Spacer()
                    SilhouetteButton(sex: "female")
                }
                .padding([.leading, .trailing], 60)
                .padding(.bottom, 100)
                
                LargeButton(label: TEXT_CONTINUE, action: maleOrFemaleContinue)

            }
        }
    }
}




