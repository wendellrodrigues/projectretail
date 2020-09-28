//
//  SignUpButton.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SignUpButton: View {
    
    @State var tap = false
    @State var press = false
    
    @Binding var success: Bool
    @Binding var loading: Bool
    
    
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
            ZStack {
                Text(TXT_SIGN_UP_BUTTON)
                    .modifier(SignInButtonModifier(tap: self.tap, press: self.press))
                    .gesture(
                        LongPressGesture(minimumDuration: 0.1, maximumDistance: 10).onChanged { value in
                            self.tap = true
                            self.loading = true
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
                    .opacity(loading ? 0 : 1)
                LottieView(fileName: "Loading")
                    .frame(width: 300, height: 90, alignment: .center)
                    .opacity(loading ? 1 : 0)
                }
            Spacer()
        }
    }
}

