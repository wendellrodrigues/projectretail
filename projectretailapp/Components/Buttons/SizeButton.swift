//
//  SizeButton.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/19/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SizeButton: View {
    
    @Binding var isSelected: Bool
    @State var label: String
    
    var body: some View {
        Text(label)
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(isSelected ? Color.white : Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
            .frame(width: 50, height: 40, alignment: .center)
            .background(
                ZStack {
                    isSelected ? Color.black : Color(#colorLiteral(red: 0.5936584892, green: 0.7996755037, blue: 1, alpha: 1))
                    
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        .blur(radius: isSelected ? 2 : 4)
                        .offset(x: -8, y: -8)
                    
                    RoundedRectangle(cornerRadius: 2, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(
                                            colors: isSelected ? [Color.black, Color.black] : [Color(#colorLiteral(red: 0.7511754478, green: 0.8607367306, blue: 1, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
        
                    )
                        .padding(2)
                        .blur(radius: 2)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.5936584892, green: 0.7996755037, blue: 1, alpha: 1)), radius: 20, x: 20, y: 20)
            .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
            .animation(.easeInOut)
    }
}

