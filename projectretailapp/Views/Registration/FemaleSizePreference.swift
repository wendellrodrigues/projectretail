//
//  FemaleSizePreference.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/16/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct FemaleSizePreference: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var sizingPreferences: SizingPreferences

    
    var body: some View {
        VStack {
            Text("Male")
            Text("Back")
                .onTapGesture {
                    //In case there is a male preference, the back button will go to male
                    //If there is no male preference, the back button will go to SexPreference()
                    if(sizingPreferences.hasSelectedMale == true) { viewRouter.currentPage = "male" }
                    else { viewRouter.currentPage = "sexPreference" }
                }
        }
        .background(Color.blue)
    }
}

