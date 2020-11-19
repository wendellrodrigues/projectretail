//
//  SilhouetteButton.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/28/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SilhouetteButton: View {
    
    @EnvironmentObject var sizingPreferences: SizingPreferences
    @State var sex: String
    
    func haptic(type: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(type)
    }

    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
    
    //Handles opacity
    func checkMaleFemale() -> Bool {
        if(sex == "male") {
            if(sizingPreferences.hasSelectedMale == true) { return true }
            else { return false }
        }
        else {
            if(sizingPreferences.hasSelectedFemale == true) { return true }
            else { return false }
        }
    }
    
    
    var body: some View {
        VStack {
            Image(sex == "male" ? "maleSilhouette" : "femaleSilhouette")
                .resizable()
                .frame(width: 80, height: 200, alignment: .center)
                .gesture(
                    LongPressGesture(minimumDuration: 0.1, maximumDistance: 10).onChanged { value in
                        haptic(type: .success)
                        if(sex == "male") {
                            sizingPreferences.hasSelectedMale.toggle()
                        } else {
                            sizingPreferences.hasSelectedFemale.toggle()
                        }
                    }
                )
                .opacity(checkMaleFemale() ? 1 : 0.2)
                .animation(.easeInOut)
                .padding(.bottom, 20)
            
            Text(sex == "male" ? "Men's" : "Women's")
                .font(Font.custom("DMSans-Bold", size: 14.5))
                .opacity(checkMaleFemale() ? 1 : 0.2)
        }

    }
}


