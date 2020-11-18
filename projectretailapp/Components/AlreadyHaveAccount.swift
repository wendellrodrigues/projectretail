//
//  AlreadyHaveAccount.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct AlreadyHaveAccount: View {
    
    var body: some View {
        HStack {
            Text(TXT_ALREADY_HAVE_ACCOUNT)
                .font(Font.custom("DMSans-Medium", size: 14.5))
                .foregroundColor(.gray)
            Spacer()
            Text(TXT_SIGN_IN)
                .font(Font.custom("DMSans-Bold", size: 14.5))
                .foregroundColor(.gray)
        }
        
        .padding([.leading, .trailing], 20)
        .padding(.top, 10)
    }
    
}
