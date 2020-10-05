//
//  Helpers.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import SwiftUI


struct Queue<T> {
  private var elements: [T] = []

  mutating func enqueue(_ value: T) {
    elements.append(value)
  }

  mutating func dequeue() -> T? {
    guard !elements.isEmpty else {
      return nil
    }
    return elements.removeFirst()
  }

  var head: T? {
    return elements.first
  }

  var tail: T? {
    return elements.last
  }
}





