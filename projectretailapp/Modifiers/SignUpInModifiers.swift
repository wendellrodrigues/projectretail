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

//Boxes that contain SignUp/sign in Fields
struct SignUpBoxFieldsModifier: ViewModifier {
    
    let typing: Bool

    func body(content: Content) -> some View {
        content
            .background(Color.offWhite)
            //.padding(.top, 100)
            //.padding()
            .cornerRadius(9)
            .padding([.leading, .trailing])
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            //.shadow(color: Color(.gray).opacity(0.1), radius: 2, x: 0, y: 2)
            //.scaleEffect(typing ? 1.08 : 1)
        

            
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
    
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.offWhite)
//            .background(LinearGradient(gradient: Gradient(colors: [firstColor, secondColor]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(5)
            //.shadow(radius: 10, x: 0, y: 10)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            .padding()
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







