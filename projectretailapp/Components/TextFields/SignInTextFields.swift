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
            Divider()
                .padding(.top, 5)
                .padding(.bottom, 10)
            PasswordTextField(password: $password, typing: $typing, confirmed: false)
        }
        .modifier(SignUpBoxFieldsModifier())
    }
}

