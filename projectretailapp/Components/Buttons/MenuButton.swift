//
//  MenuButton.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/27/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct MenuButton: View {
    
    @Binding var showProfile: Bool
    
    @State var tap: Bool = false
    @State var press: Bool = false
    
    var body: some View {
        Image(systemName: "line.horizontal.3")
            .modifier(MenuButtonModifier(showProfile: $showProfile, tap: tap, press: press))
            .gesture(
                LongPressGesture(minimumDuration: 0.1, maximumDistance: 1).onChanged { value in
                    self.tap = true
                    haptic(type: .success)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.tap = false
                        showProfile.toggle()
                    }
                }
                .onEnded { value in
                    self.press.toggle()
                }
            )

    }
}

