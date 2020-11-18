//
//  CreateAccountText.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct CreateAccountText: View {
    
   // @Binding var typing: Bool
    
    var body: some View {
        HStack {
            Text(TXT_CREATE_ACCOUNT)
                .font(.custom("DMSans-Medium", size: 14.5))
                .foregroundColor(.gray)
            Spacer()
            Text(TXT_SIGN_UP_BUTTON)
                .font(.custom("DMSans-Bold", size: 14.5))
                .foregroundColor(.gray)
                
        }
        .padding([.leading, .trailing], 20)
        .padding(.top, 10)
    }
    
}


