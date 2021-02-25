//
//  Store.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/30/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import SwiftUI

struct Beacon: Decodable {
    var UUID: String
    var major: Int
    var minor: Int
    var name: String
    var sizes: [SizeType]
    var image: String
    var color: String
    var description: String
    var price: Int
    var type: String
}

//Local Beacon Objects
struct BeaconRef: Encodable, Decodable {
    var uuid: String
    var major: Int
    var minor: Int
}

struct ShelfBrief: Identifiable {
    var id: UUID
    let uid: String
    let image: UIImage
}

struct SizeType: Decodable {
    let maleLengthSize: Int
    let maleWaistSize: Int
    let maleShirtSize: String
    let femaleShirtSize: String
    let femalePantSize: String
    let shelf: Int
}




