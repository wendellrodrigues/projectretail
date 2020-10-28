//
//  ButtonModifiers.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/28/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import SwiftUI


//For SignUp, SignIn type buttons. Large lower screen buttons
struct LargeButtonModifier: ViewModifier {
    
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



