//
//  SignUp_PasswordTextField.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/26/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SignUpPasswordTextField: View {
    
    @Binding var password: String
    
    @Binding var typingFirstName: Bool
    @Binding var typingEmail: Bool
    @Binding var typingPwd: Bool
    @Binding var typingConfirmPwd: Bool
    
    var body: some View {
        
        HStack {
        SecureField(TXT_PWD, text: $password, onCommit: {self.typingPwd = false})
            .onTapGesture {
                self.typingFirstName = false
                self.typingEmail = false
                self.typingPwd = true
                self.typingConfirmPwd = false
            }
            .frame(minWidth: 50, minHeight: 40)
            .disableAutocorrection(true)
            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            .keyboardType(.emailAddress)
            .font(.system(size: 14.5, weight: .medium, design: .default))
            .padding(.leading, typingPwd ? 10 : 40)
            .textFieldFocusableArea()
    }
        .overlay(
            HStack {
                Image(systemName: PWD_ICON)
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(typingPwd ? 0 : 1))
                    .frame(width: typingPwd ? 290 : 54, height: typingPwd ? 4 : 50)
                    .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(typingPwd ? 1 : 0))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 10, x: 10, y: 10)
                    .offset(x: typingPwd ? 10 : -10, y: typingPwd ? 20 : 0)
                Spacer()
            }
        )
    }
}


