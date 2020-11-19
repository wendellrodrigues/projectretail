//
//  ButtonModifiers.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/28/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import SwiftUI

func haptic(type: UINotificationFeedbackGenerator.FeedbackType) {
    UINotificationFeedbackGenerator().notificationOccurred(type)
}

func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
    UIImpactFeedbackGenerator(style: style).impactOccurred()
}

//For SignUp, SignIn type buttons. Large lower screen buttons
struct LargeButtonModifier: ViewModifier {
    
    var tap: Bool
    var press: Bool
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("DMSans-Bold", size: 18))
            .foregroundColor(Color("Button_Text"))
            .frame(width: 350, height: 70, alignment: .center)
            .background(Color("Button_Background"))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .scaleEffect(tap ? 0.9 : 1)
    }
}




struct MenuButtonModifier: ViewModifier {
    
    @Binding var showProfile: Bool

    var tap: Bool
    var press: Bool
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.black.opacity(0.8))
            .font(Font.custom("DMSans-Bold", size: 30))
    }
}



