//
//  HalfButton.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/28/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

//Button that takes up half the screen, can either be continue, or back

import SwiftUI

struct HalfButton: View {
    
    @State var label: String
    
    var body: some View {
        Text(label)
    }
}


