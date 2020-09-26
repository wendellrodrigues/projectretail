//
//  SignUpInTextFields.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SignInTextFields: View {
    
    @Binding var email: String
    @Binding var password: String
    @Binding var typing: Bool
    
    var body: some View {
        VStack {
            EmailTextField(email: $email, typing: $typing)
                .padding()
                .padding(.top, 10)
            Divider()
                .padding([.leading, .trailing], 15)
            PasswordTextField(password: $password, typing: $typing, confirmed: false)
                .padding()
                .padding(.bottom, 10)
        }
        .modifier(SignUpBoxFieldsModifier(typing: typing))
    }
}

