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
            .frame(width: screen.width - 50)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .padding(.horizontal, 30)
            .padding([.top, .bottom], 30)
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
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .edgesIgnoringSafeArea(.all)
            .scaleEffect(showProfile ? 0.95 : 1)
            .offset(y: showProfile ? -450 : 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .padding(.horizontal, 30)
            
    }
}



