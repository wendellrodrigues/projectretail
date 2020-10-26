//
//  sizingPreferences.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/14/20.
//  Copyright © 2020 Wendell. All rights reserved.
//
import Foundation
import Combine
import SwiftUI
import Firebase
import FirebaseFirestoreSwift


//Changing Sizing Preferences
class SizingPreferences: ObservableObject {

    let objectWillChange = PassthroughSubject<SizingPreferences,Never>()
    
    @Published var hasSelectedMale: Bool = false {
        didSet { objectWillChange.send(self) }
    }
    
    @Published var hasSelectedFemale: Bool = false {
        didSet { objectWillChange.send(self) }
    }
    

}
