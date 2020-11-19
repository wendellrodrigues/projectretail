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
            .font(.custom("DMSans-Bold", size: 14))
            .foregroundColor(isMarked ? Color.white : Color("Primary"))
            .frame(width: 40, height: 35, alignment: .center)
            .background(isMarked ? Color.black : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
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

