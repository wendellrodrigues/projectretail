//
//  FirstNameTextField.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/4/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct FirstNameTextField: View {
    
    @Binding var firstName: String
    @Binding var typing: Bool
    
    var body: some View {
        HStack {
            Image(systemName: USER_ICON)
                .modifier(IconFieldsModifier(typing: typing))
            TextField(TXT_FIRST_NAME, text: $firstName, onCommit: {self.typing = false})
                .disableAutocorrection(true)
                .autocapitalization(.words)
                .keyboardType(.default)
                .font(.system(size: 14.5, weight: .medium, design: .default))
                .onTapGesture {
                    self.typing = true
                }
        }
        
       
    }
}


