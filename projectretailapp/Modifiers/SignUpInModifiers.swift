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
    
    let typing: Bool

    func body(content: Content) -> some View {
        content
            .background(Color.offWhite)
            .cornerRadius(9)
            .padding([.leading, .trailing])
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)

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
    
//    let colors = Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red])
//
//    let firstColor = Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
//    let secondColor = Color(#colorLiteral(red: 0.213008909, green: 0.2560196571, blue: 0.6285351563, alpha: 1))
    
    var tap: Bool
    var press: Bool
    
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(Color.black.opacity(0.8))
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
        
        //            .overlay(
        //                HStack {
        //                    Image(systemName: "person.crop.circle")
        //                        .font(.system(size: 24, weight: .light))
        //                        .foregroundColor(Color.white.opacity(press ? 0 : 1))
        //                        .frame(width: press ? 64 : 54, height: press ? 4 : 50)
        //                        .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
        //                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        //                        .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 10, x: 10, y: 10)
        //                        .offset(x: press ? 70 : -10, y: press ? 16 : 0)
        //
        //
        //                    Spacer()
        //                }
        //
        //
        //        )
    }
}

struct ErrorMessageModifier: ViewModifier {
    
    var typing: Bool

    func body(content: Content) -> some View {
           content
            .font(.footnote)
            .foregroundColor(Color.gray)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
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







