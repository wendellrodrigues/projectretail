//
//  SignUpButton.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SignUpButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Spacer()
            Text(TXT_REGISTER_BUTTON)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            Spacer()
        }
    .modifier(RegisterButtonModifier())
    }
}

