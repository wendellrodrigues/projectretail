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
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            Text("Male")
                .onTapGesture {
                    print("male : \(sizingPreferences.hasSelectedMale)")
                    print("female : \(sizingPreferences.hasSelectedFemale)")
                }
            Text("Back")
                .onTapGesture {
                    viewRouter.currentPage = "sexPreference"
                }
            if(sizingPreferences.hasSelectedFemale == true) {
                Text("Next")
                    .onTapGesture {
                        viewRouter.currentPage = "female"
                    }
            }
        }.background(Color.blue)
       
    }
    
}





