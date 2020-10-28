//
//  HalfButton.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/28/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

//Button that takes up half the screen, can either be continue, or back

import SwiftUI

struct HalfButton: View {
    
    @State var tap = false
    @State var press = false
    
    @State var label: String
    
    var action: () -> Void
    
    
    var body: some View {
        HStack {
            Spacer()

            Text(label)
                .modifier(HalfButtonModifier(tap: self.tap, press: self.press))
                .gesture(
                    LongPressGesture(minimumDuration: 0.1, maximumDistance: 10).onChanged { value in
                        self.tap = true

                        action()
                        haptic(type: .success)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.tap = false
                            action()
                        }
       
                    }
                    .onEnded { value in
                        self.press.toggle()
                    }
                )
            Spacer()

        }
    }
}


