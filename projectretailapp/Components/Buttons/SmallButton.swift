//
//  LargeButton.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/28/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SmallButton: View {
    
    @State var tap = false
    @State var press = false
    
    @State var label: String
    
    var action: () -> Void
    
    
    var body: some View {
        HStack {
            Spacer()
            Text(label)
                .modifier(SmallButtonModifier(tap: self.tap, press: self.press))
                .onTapGesture {
                    action()
                    haptic(type: .success)
                }
            Spacer()
        }
    }
    
}
