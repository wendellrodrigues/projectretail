//
//  SignUpTextFields.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SignUpTextFields: View {
    
    @Binding var firstName: String
    @Binding var email: String
    @Binding var password: String
    @Binding var confirmedPassword: String
    
    @Binding var typingFirstName: Bool
    @Binding var typingEmail: Bool
    @Binding var typingPwd: Bool
    @Binding var typingConfirmPwd: Bool
    
    var body: some View {
        VStack {
 
            SignUpFirstNameTextField(firstName: $firstName,
                                     typingFirstName: $typingFirstName,
                                     typingEmail: $typingEmail,
                                     typingPwd: $typingPwd,
                                     typingConfirmPwd: $typingConfirmPwd)
                .padding([.leading])
                .padding([.top, .bottom])

            
            SignUpEmailTextField(email: $email,
                                 typingFirstName: $typingFirstName,
                                 typingEmail: $typingEmail,
                                 typingPwd: $typingPwd,
                                 typingConfirmPwd: $typingConfirmPwd)
                .padding(.leading)
                .padding([.top, .bottom])
            
            SignUpPasswordTextField(password: $password,
                                    typingFirstName: $typingFirstName,
                                    typingEmail: $typingEmail,
                                    typingPwd: $typingPwd,
                                    typingConfirmPwd: $typingConfirmPwd)
                .padding(.leading)
                .padding([.top, .bottom])
            
            SignUpConfirmPasswordTextField(confirmPwd: $confirmedPassword,
                                           typingFirstName: $typingFirstName,
                                           typingEmail: $typingEmail,
                                           typingPwd: $typingPwd,
                                           typingConfirmPwd: $typingConfirmPwd)
                .padding([.leading, .bottom])
        }
    .modifier(SignUpBoxFieldsModifier())
        
    }
}

