//
//  Store.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/30/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation

struct Beacon {
    var UUID: String
    var major: Int
    var minor: Int
    var name: String
    var sizes: [Any]
}

//Local Beacon Objects
struct BeaconRef: Encodable, Decodable {
    var uuid: String
    var major: Int
    var minor: Int
}



