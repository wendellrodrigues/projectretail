//
//  SignInButton.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import SwiftUI

struct SignInButton: View {
    
    @State var tap = false
    @State var press = false
    
    func haptic(type: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(type)
    }

    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
    
    
    var action: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Text(TXT_SIGN_IN_BUTTON)
                .modifier(SignInButtonModifier(tap: self.tap, press: self.press))
                .gesture(
                    LongPressGesture(minimumDuration: 0.1, maximumDistance: 10).onChanged { value in
                        self.tap = true
                        action()
                        haptic(type: .success)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.tap = false
                        }
                    }
                    .onEnded { value in
                        self.press.toggle()
                    }
            )
            Spacer()
        }
    }
    
    
    
//    var body: some View {
//        Button(action: action) {
//            Spacer()
//            Text(TXT_SIGN_IN_BUTTON)
//                .fontWeight(.bold)
//                .foregroundColor(Color.white)
//            Spacer()
//        }
//    .modifier(SignInButtonModifier())
//    }
}

