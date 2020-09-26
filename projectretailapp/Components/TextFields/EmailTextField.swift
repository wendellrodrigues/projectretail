//
//  EmailTextField.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/30/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct EmailTextField: View {
    
    @Binding var email: String
    @Binding var typing: Bool
    
    var body: some View {
        HStack {
            Image(systemName: EMAIL_ICON)
                .modifier(IconFieldsModifier(typing: typing))
            TextField(TXT_EMAIL, text: $email, onCommit: {self.typing = false
                print(self.typing)
            })
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .keyboardType(.emailAddress)
                .font(.system(size: 14.5, weight: .medium, design: .default))
                .onTapGesture {
                    self.typing = true
                    print(self.typing)
                }
        }
    }
}


