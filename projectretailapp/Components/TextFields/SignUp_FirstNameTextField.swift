//
//  FirstNameTextField.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/4/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SignUpFirstNameTextField: View {
    
    @Binding var firstName: String
    
    @Binding var typingFirstName: Bool
    @Binding var typingEmail: Bool
    @Binding var typingPwd: Bool
    @Binding var typingConfirmPwd: Bool
    
    var body: some View {
        
        HStack {
        TextField(TXT_FIRST_NAME, text: $firstName, onCommit: {self.typingFirstName = false})
            .onTapGesture {
                self.typingFirstName = true
                self.typingEmail = false
                self.typingPwd = false
                self.typingConfirmPwd = false
            }
            .frame(minWidth: 50, minHeight: 40)
            .disableAutocorrection(true)
            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            .keyboardType(.emailAddress)
            .font(.system(size: 14.5, weight: .medium, design: .default))
            .padding(.leading, typingFirstName ? 10 : 40)
            
            .textFieldFocusableArea()
    }
        .overlay(
            HStack {
                Image(systemName: USER_ICON)
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(typingFirstName ? 0 : 1))
                    .frame(width: typingFirstName ? 290 : 54, height: typingFirstName ? 4 : 50)
                    .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(typingFirstName ? 1 : 0))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 10, x: 10, y: 10)
                    .offset(x: typingFirstName ? 10 : -10, y: typingFirstName ? 20 : 0)
                    
                Spacer()
            }
        )
    }
}



