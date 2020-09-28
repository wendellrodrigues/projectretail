//
//  ViewRouter.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/27/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ViewRouter: ObservableObject {
    
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    var currentPage: String = "signin" {
        didSet {
            objectWillChange.send(self)
        }
    }
    
}
