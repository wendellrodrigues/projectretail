//
//  HomeModifiers.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/27/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import SwiftUI

//Modifier for Menu
struct MenuModifier: ViewModifier {
    

    let screen = UIScreen.main.bounds

    func body(content: Content) -> some View {
        content
            .frame(width: screen.width - 50, height: 150)
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
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.5936584892, green: 0.7996755037, blue: 1, alpha: 1)), radius: 20, x: 20, y: 20)
            .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
            .padding(.horizontal, 30)

    }
}



//Modifier for home screen
struct HomeModifier: ViewModifier {
    
    @Binding var showProfile: Bool
    @Binding var viewState: CGSize
    
    let screen = UIScreen.main.bounds

    func body(content: Content) -> some View {
        content
            .frame(width: screen.width, height: screen.height)
            

            .background(
                ZStack {
                    Color(#colorLiteral(red: 0.5936584892, green: 0.7996755037, blue: 1, alpha: 1))
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        .blur(radius: 4)
                        .offset(x: -8, y: -8)
                    
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7511754478, green: 0.8607367306, blue: 1, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                        .padding(2)
                        .blur(radius: 2)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .edgesIgnoringSafeArea(.all)
            .scaleEffect(showProfile ? 0.9 : 1)
            .offset(y: showProfile ? -450 : 0)
            .rotation3DEffect(Angle(degrees: showProfile ? Double(viewState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            
            .shadow(color: Color(#colorLiteral(red: 0.5936584892, green: 0.7996755037, blue: 1, alpha: 1)), radius: 20, x: 20, y: 20)
            .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
            .padding(.horizontal, 30)
            
    }
}



