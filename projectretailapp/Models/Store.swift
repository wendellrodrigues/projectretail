//
//  Store.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/30/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation

struct Store: Encodable, Decodable {
    var uid: String
    var beacons: Array<Beacon> = []
}


struct Beacon: Encodable, Decodable {
    var uuid: String
    var major: Int
    var minor: Int
}
