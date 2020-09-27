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
    @Binding var typingEmail: Bool
    @Binding var typingPassword: Bool
    
    var body: some View {
        VStack {
            SignInEmailTextField(email: $email, typingEmail: $typingEmail, typingPassword: $typingPassword)
                .padding()
                .padding(.top, 10)

            SignInPasswordTextField(password: $password, typingEmail: $typingEmail, typingPassword: $typingPassword)
                .padding()
                .padding(.bottom, 15)
        }
        .modifier(SignUpBoxFieldsModifier())
    }
}

