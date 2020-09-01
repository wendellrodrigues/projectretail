//
//  SignUpButton.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SignUpButton: View {
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
            Spacer()
            Text(TXT_REGISTER_BUTTON)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            Spacer()
        }
    .modifier(RegisterButtonModifier())
    }
}

struct SignUpButton_Previews: PreviewProvider {
    static var previews: some View {
        SignUpButton()
    }
}
