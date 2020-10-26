//
//  SizeButton.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/19/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SizeButton: View {
    
    @State var tap = false
    @State var press = false
    
    let id: String
    let label: String
    let isMarked: Bool
    let callback: (String)->()
    
    init(id: String,
         label: String,
         isMarked: Bool = false,
         callback: @escaping (String)->()
    ) {
        self.id = id
        self.label = label
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View {
        Text(label)
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(isMarked ? Color.white : Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
            .frame(width: 50, height: 40, alignment: .center)
            .background(
                ZStack {
                    isMarked ? Color.black : Color(#colorLiteral(red: 0.5936584892, green: 0.7996755037, blue: 1, alpha: 1))
                    
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        .blur(radius: isMarked ? 2 : 4)
                        .offset(x: -8, y: -8)
                    
                    RoundedRectangle(cornerRadius: 2, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(
                                            colors: isMarked ? [Color.black, Color.black] : [Color(#colorLiteral(red: 0.7511754478, green: 0.8607367306, blue: 1, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                        .padding(2)
                        .blur(radius: 2)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.5936584892, green: 0.7996755037, blue: 1, alpha: 1)), radius: 20, x: 20, y: 20)
            .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
            .animation(.easeInOut)
            .gesture(
                LongPressGesture(minimumDuration: 0.1, maximumDistance: 10).onChanged { value in
                    self.callback(self.id)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.tap = false
                    }
                    haptic(type: .success)
                    
                }.onEnded { value in
                    self.press.toggle()
                }
                
            )
    }
}

