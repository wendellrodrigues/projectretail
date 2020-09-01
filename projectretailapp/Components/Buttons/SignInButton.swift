//
//  SignInButton.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import SwiftUI

struct SignInButton: View {
    
    //var action: () -> Void
    
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
            Spacer()
            Text(TXT_SIGN_IN_BUTTON)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            Spacer()
        }
    .modifier(SignInButtonModifier())
    }
}

