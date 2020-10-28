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








