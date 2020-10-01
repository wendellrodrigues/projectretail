//
//  SignUp_EmailTextField.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/26/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SignUpEmailTextField: View {
    
    @Binding var email: String
    
    @Binding var typingFirstName: Bool
    @Binding var typingEmail: Bool
    @Binding var typingPwd: Bool
    @Binding var typingConfirmPwd: Bool
    
    var body: some View {
        
        HStack {
            TextField(TXT_EMAIL, text: $email, onCommit: {self.typingEmail = false})
                //.textFieldStyle(PlainTextFieldStyle())
                //.frame(minWidth: 50, minHeight: 40)
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .keyboardType(.emailAddress)
                .font(.system(size: 14.5, weight: .medium, design: .default))
                .padding(.leading, typingEmail ? 10 : 40)
                .textFieldFocusableArea()
                .onTapGesture {
                    self.typingFirstName = false
                    self.typingEmail = true
                    self.typingPwd = false
                    self.typingConfirmPwd = false
                }
    }
        .overlay(
            HStack {
                Image(systemName: EMAIL_ICON)
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(typingEmail ? 0 : 1))
                    .frame(width: typingEmail ? 290 : 54, height: typingEmail ? 4 : 50)
                    .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(typingEmail ? 1 : 0))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 10, x: 10, y: 10)
                    .offset(x: typingEmail ? 10 : -10, y: typingEmail ? 20 : 0)
                Spacer()
            }
        )
    }
}


