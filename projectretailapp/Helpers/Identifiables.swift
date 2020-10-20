//
//  Identifiables.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/19/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation


extension Int: Identifiable {
    public var id: Int {
        self
    }
}


extension String: Identifiable {
    public var id: String {
        self
    }
}
