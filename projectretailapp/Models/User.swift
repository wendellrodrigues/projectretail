//
//  User.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation

struct User: Encodable, Decodable {
    var uid: String
    var firstName: String
    var email: String
    
    //For user styles (predicted)
    var styles: Array<String> = []
}


