//
//  Modifiers.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/30/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}

func haptic(type: UINotificationFeedbackGenerator.FeedbackType) {
    UINotificationFeedbackGenerator().notificationOccurred(type)
}

func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
    UIImpactFeedbackGenerator(style: style).impactOccurred()
}

//Boxes that contain SignUp/sign in Fields
struct SignUpBoxFieldsModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
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
            .shadow(color: Color(#colorLiteral(red: 0.5936584892, green: 0.7996755037, blue: 1, alpha: 1)), radius: 20, x: 10, y: 10)
            .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -10, y: -10)
            .padding()

    }
}

//Icon inside signup/signin fields
struct IconFieldsModifier: ViewModifier {
    
    let typing: Bool
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.gray)
            .padding(.trailing, 10)
            .padding(.bottom,1)
            .opacity(typing ? 0.2 : 0.5)
            .font(.footnote)
            
    }
}

struct BackgroundImageModifier: ViewModifier {
    
    let typing: Bool
    
    func body(content: Content) -> some View {
        content
            .opacity(typing ? 0.8 : 0.4)
            .blur(radius: 50)
    }
}


//Sign UpIn Button Modifier
struct SignInButtonModifier: ViewModifier {
    
    var tap: Bool
    var press: Bool
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
            .frame(width: 350, height: 60, alignment: .center)
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

struct ContinueButtonLargeModifier: ViewModifier {
    
    var tap: Bool
    let press: Bool
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
            .frame(width: 350, height: 60, alignment: .center)
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
            .animation(.easeInOut)
    }
}

struct ErrorMessageModifier: ViewModifier {

    func body(content: Content) -> some View {
           content
            .font(.footnote)
            .foregroundColor(Color(#colorLiteral(red: 0.1430806571, green: 0.1941335433, blue: 0.2437695313, alpha: 1)))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            .padding(.bottom, 10)
       }
}

struct PasswordHelpModifier: ViewModifier {
    
    var typing: Bool

    func body(content: Content) -> some View {
           content
            .font(.footnote)
            .foregroundColor(Color.gray)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
       }
}


//Sign UpIn Button Modifier
struct RegisterButtonModifier: ViewModifier {
    
    let colors = Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red])
    
    let firstColor = Color(#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1))
    let secondColor = Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
    
    func body(content: Content) -> some View {
        content
            .padding(.top, 50)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [firstColor, secondColor]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(5)
            .shadow(radius: 10, x: 0, y: 10)
            .padding()
    }
}







