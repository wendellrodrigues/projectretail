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

struct HalfButtonModifier: ViewModifier {
    
    var tap: Bool
    var press: Bool
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
            .frame(width: 155, height: 60, alignment: .center)
            .background(
                ZStack {
                    Color(#colorLiteral(red: 0.5936584892, green: 0.7996755037, blue: 1, alpha: 1))
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        .blur(radius: 4)
                        .offset(x: -8, y: -8)
                    
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7511754478, green: 0.8607367306, blue: 1, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                        .padding(2)
                        .blur(radius: 2)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.5936584892, green: 0.7996755037, blue: 1, alpha: 1)), radius: 20, x: 20, y: 20)
            .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
            .scaleEffect(tap ? 0.9 : 1)
    }
}



struct MenuButtonModifier: ViewModifier {
    
    @Binding var showProfile: Bool

    var tap: Bool
    var press: Bool
    
    func body(content: Content) -> some View {
        content
            //.foregroundColor(Color(#colorLiteral(red: 0.3713087538, green: 0.4720684171, blue: 0.63421875, alpha: 1)))
            .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
            .background(
                ZStack {
                    Color(#colorLiteral(red: 0.5936584892, green: 0.7996755037, blue: 1, alpha: 1))
                        .clipShape(Circle())
                    Circle()
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        .blur(radius: 4)
                        .offset(x: -8, y: -8)
                    Circle()
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7511754478, green: 0.8607367306, blue: 1, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                        .padding(2)
                        .blur(radius: 2)
                }
                .frame(width: 60, height: 60)
                .scaleEffect(tap ? 0.9 : 1)
            
            )

            .shadow(color: Color(#colorLiteral(red: 0.5936584892, green: 0.7996755037, blue: 1, alpha: 1)), radius: 5, x: 2, y: 2)
            .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 5, x: 0, y: 0)
            .font(.system(size: 20, weight: .medium))
    }
}



