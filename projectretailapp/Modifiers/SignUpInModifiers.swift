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
        
            .background(Color("TextField_Background"))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
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
            .font(Font.custom("DMSans-Medium", size: 12))
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








